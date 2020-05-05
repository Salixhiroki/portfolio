# frozen_string_literal: true

class RecipesController < ApplicationController
  protect_from_forgery except: :create
  attr_accessor :material_name, :material_quantity, :method
  before_action :all_comments, only: [:show]
  #-------------------------------------------------------------------------------------------------</>

  # 親モデルのインスタンス作成、buildで関係性のある子モデルのインスタンスを作成
  def new
    @recipe = Recipe.new
    @cookmethod = @recipe.cookmethods.build
    @material = @recipe.materials.build
  end

  #-------------------------------------------------------------------------------------------------</>

  # 新規作成
  def create
    # レシピと材料のオブジェクトを作成
    @recipe = Recipe.new(user_id: recipe_params[:user_id], title: recipe_params[:title], point: recipe_params[:point], image: recipe_params[:image], impression: recipe_params[:impression])
    @recipe.user_id = current_user.id

    if @recipe.save
      # 材料名と分量を格納、保存
      recipe_params[:materials_attributes]['0']['material_name'].zip(recipe_params[:materials_attributes]['0']['material_quantity']).each do |m_name, m_quantity|
        @material = @recipe.materials.create!(user_id: current_user.id, material_name: m_name, material_quantity: m_quantity)

        if m_name != '' && m_quantity != ''
          @material.save
        elsif (m_name == '' && m_quantity != '') || (m_name != '' && m_quantity == '')
          @material.save
        else
          @material.delete
        end
      end

      # 作り方を格納、保存
      recipe_params[:cookmethods_attributes]['0']['method'].each do |cm|
        @cookmethod = @recipe.cookmethods.create!(user_id: current_user.id, method: cm)
        if cm != ''
          @cookmethod.save
        else
          @cookmethod.delete
        end
      end

      redirect_to recipes_path, success: 'レシピを投稿しました！'
    else
      flash.now[:danger] = 'レシピの投稿に失敗しました'
      render "recipes/new"
    end
  end

  #-------------------------------------------------------------------------------------------------</>

  # 投稿一覧
  def index
    @recipes = Recipe.all
    # @q_recipe=Recipe.ransack(params[:q])

    # @q_method=Cookmethod.ransack(params[:q])
    @q = Material.ransack(params[:q])
    @q_materials = @q.result(distinct: true)
    # binding pry
    # @recipe_q = @q.result(distinct: true)
    # @method_q = @q.result(distinct: true)

    # binding pry
  end

  #-------------------------------------------------------------------------------------------------</>
  # レシピ検索
  def search
    @q = Material.ransack(params[:q])
    # binding pry
    if search_params[:material_name_cont] != '' && @q.result(distinct: true) != nil
      
      @materials_q = @q.result(distinct: true)
      i = 0
      @recipe_id = []
      @recipes_q = []
      @user_results = []
      
      if @materials_q != []
        @materials_q.each do |material_q|
          logger.debug(material_q.recipe_id)
          @recipe_id[i] = material_q.recipe_id
          @recipes_q[i] = Recipe.where(id: @recipe_id[i])
          @user_results[i] = User.find_by(id: material_q.user_id)
          i += 1
        end
        @q_size = i - 1
      else
        @nothing = 1
        render :search
      end
    else
      # binding pry
      @nothing = 1
      render :search
    end
  end

  #-------------------------------------------------------------------------------------------------</>

  # 投稿詳細
  def show
    @detail = Recipe.find_by(id: params[:id])
    @detail_material = Material.where(user_id: @detail.user_id, recipe_id: @detail.id)
    # binding pry
    @detail_method = Cookmethod.where(user_id: @detail.user_id, recipe_id: @detail.id)
    @detail_method = @detail_method.rank(:row_order)
    @n= @detail_material.length
    @m =  @detail_method.length
    @user = User.find_by(id: @detail.user_id)
  end

  #-------------------------------------------------------------------------------------------------</>

  # 編集対象のレシピの情報を格納
  def edit
    @recipe = Recipe.find_by(id: params[:id])
   
    @material = Material.where(user_id: @recipe.user_id, recipe_id: @recipe.id)
    @cookmethod = Cookmethod.where(user_id: @recipe.user_id, recipe_id: @recipe.id)
    @cookmethod = @cookmethod.order(row_order: "ASC")
  end

  #-------------------------------------------------------------------------------------------------</>
  #並べ替えを保存する
  def sort
    # binding pry
    sort_recipe = Cookmethod.find(recipe_params[:method_id])
    sort_recipe.update(row_order_position: recipe_params[:row_order_position].to_i)
    # binding pry
    render body: nil
  end

  #----------------------------------<//>
  # 編集内容の取得と保存
  def update
    # recipesテーブルの情報を取得
    @recipe = Recipe.find_by(id: params[:id])
    @update_user_id = @recipe.user_id

    # materialsテーブルの情報を取得
    @material = Material.where(user_id: @update_user_id, recipe_id: params[:id])

    # cookmethosテーブルの情報を取得
    @cookmethod = Cookmethod.where(user_id: @update_user_id, recipe_id: params[:id])
    # @cookmethod = @cookmethod.order(row_order: "ASC")
    @cookmethod = Cookmethod.rank(:row_order)
    # logger.debug(@material)

    #----------------------------------<//>

    # recipesテーブルを更新
    @recipe_cnt = 0 # カウンタ変数
    # binding pry
    if @recipe.update(recipe_params)
      @recipe_cnt += 1 
    end
    # binding pry
    #----------------------------------<//>

    # materialのデータをハッシュに変換してそれに格納されている要素数を格納
    @m_lengths = recipe_params[:materials_attributes].to_h.length
    # logger.debug(@m_lengths)
    @material_cnt = 0 # カウンタ変数
    num = 0 # カウンタ変数
    @nothing_material = [] # 空の配列作成
    
    # binding pry

    # 要素数分ループする
    for m_length in 0..@m_lengths-1 do
      # もし配列の中身が2つ以上だったらそれを取り出して保存する。
      # idがないので新しくインスタンスに入れて保存する！
      if recipe_params[:materials_attributes][m_length.to_s][:material_name] != nil || recipe_params[:materials_attributes][m_length.to_s][:material_quantity] != nil
        @m_name = recipe_params[:materials_attributes][m_length.to_s][:material_name][0]
        @m_quantity = recipe_params[:materials_attributes][m_length.to_s][:material_quantity][0]
      else
      # binding pry
       @material[m_length].destroy
       next
      end
      
      if @m_name != '' && @m_quantity != ''
        if @material[m_length].update(material_name: @m_name) && @material[m_length].update(material_quantity: @m_quantity)
          @material_cnt += 1
        end
      elsif (@m_name == '' && @m_quantity != '') || (@m_name != '' && @m_quantity == '')
        if @material[m_length].update(material_name: @m_name) && @material[m_length].update(material_quantity: @m_quantity)
          @material_cnt += 1
        end
      else
        @nothing_material[num] = @material[m_length]
        num += 1
      end

      m_name_l = recipe_params[:materials_attributes][m_length.to_s][:material_name]
      m_names = m_name_l.length
      (1..m_names - 1).each do |n|
        m_name_else = recipe_params[:materials_attributes][m_length.to_s][:material_name][n]
        m_quantity_else = recipe_params[:materials_attributes][m_length.to_s][:material_quantity][n]
        @material.where(material_name: m_name_else, material_quantity: m_quantity_else).exists?
          @material_new = Material.new(user_id: @update_user_id, recipe_id: params[:id], material_name: m_name_else, material_quantity: m_quantity_else)
          @material_new.save
      end
    end
    #----------------------------------<//>

    @method_cnt = 0 # カウンタ変数
    @nothing_method = [] # 空の配列作成
    num = 0
    # cookmethodsのデータをハッシュに変換してそれに格納されている要素数を格納
    @method_lengths = recipe_params[:cookmethods_attributes].to_h.length 
    
    # 要素分ループする
    for method_length in 0..@method_lengths-1 do
      @method = recipe_params[:cookmethods_attributes][method_length.to_s][:method]
      if @method != nil
        @method = recipe_params[:cookmethods_attributes][method_length.to_s][:method][0]
        @method_cnt += 1 if @cookmethod[method_length].update(method: @method)
      elsif @method == nil
        @cookmethod[method_length].destroy
        next
      else
        @nothing_method[num] = @cookmethod[method_length]
        num += 1
      end
      method_l = recipe_params[:cookmethods_attributes][method_length.to_s][:method]
      puts method_l.to_s + "kodesu" 
    end
    
    @methods = method_l.length
    (1..@methods - 1).each do |n|
      method_else = recipe_params[:cookmethods_attributes][method_length.to_s][:method][n]
      @cookmethod.where(method: method_else).exists?
        method_new = Cookmethod.new(user_id: @update_user_id, recipe_id: params[:id], method: method_else)
        method_new.save
    end
    
    if @recipe_cnt == 1 && @material_cnt != 0 && @method_cnt != 0
      material_method_destroy(@nothing_material, @nothing_method) # material_method_destroyを呼び出して何も入っていない場合のレコードを削除< fn >
      redirect_to edit_recipe_path, success: 'レシピの編集をしました'
    else
      flash.now[:danger] = 'レシピの編集に失敗しました'
      render :edit
    end
  end

  #-------------------------------------------------------------------------------------------------< fn >
  def material_method_destroy(nothing_material, nothing_method)
    num = 0
    unless nothing_material.empty?
      nothing_material.each do |n_material|
        n_material&.destroy
        num += 1
      end
    end

    num = 0
    unless nothing_method.empty?
      nothing_method.each do |n_method|
        n_method&.destroy
        num += 1
      end
    end
  end

  #-------------------------------------------------------------------------------------------------< /fn >

  #-------------------------------------------------------------------------------------------------</>

  # レシピ削除
  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.destroy
      redirect_to recipes_path, success: 'レシピの削除に成功しました'
    else
      flash.now[:danger] = 'レシピの削除に失敗しました'
      render :show
    end
  end

  #-------------------------------------------------------------------------------------------------< sp >

  # Strong Parameter
  private

  def recipe_params
    params.require(:recipe).permit(:title, :point, :image, :impression,:row_order_position, :method_id,  materials_attributes: [:id, :_destroy, material_name: [], material_quantity: []], cookmethods_attributes: [:id, :_destroy, method: []])
  end

  def search_params
    params.require(:q).permit(:material_name_cont)
  end
  
  def all_comments
    @comments=Comment.all
  end
  
end

#-------------------------------------------------------------------------------------------------<///>
