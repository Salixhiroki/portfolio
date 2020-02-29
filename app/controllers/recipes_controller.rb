class RecipesController < ApplicationController
  
  protect_from_forgery except: :create
  
  attr_accessor :material_name, :material_quantity, :method
  
  # 親モデルのインスタンス作成、buildで関係性のある子モデルのインスタンスを作成
  def new
    
    @recipe=Recipe.new
    @cookmethod=@recipe.cookmethods.build
    @material=@recipe.materials.build
    
  end
  
  
  # 新規作成
  def create
    
    # レシピと材料のオブジェクトを作成
    @recipe=Recipe.new(user_id: recipe_params[:user_id],title: recipe_params[:title],point: recipe_params[:point],image: recipe_params[:image],impression: recipe_params[:impression])
    
    # ---------必要な情報を格納、保存----------#
        
    # @recipeにuser_idを格納
    @recipe.user_id=current_user.id
    
    if @recipe.save
    
      # 材料名と分量を格納、保存
      recipe_params[:materials_attributes]["0"]["material_name"].zip(recipe_params[:materials_attributes]["0"]["material_quantity"]).each do |m_name,m_quantity|
        
        
        @material=@recipe.materials.create!(user_id: current_user.id, material_name: m_name, material_quantity: m_quantity)
        
        if m_name!="" && m_quantity!=""
          @material.save
        elsif (m_name=="" && m_quantity!="") || (m_name!="" && m_quantity=="")
          @material.save
        else
          @material.delete
        end
        
      end
      
      # 作り方を格納、保存
      recipe_params[:cookmethods_attributes]["0"]["method"].each do |cm|
        
        @cookmethod=@recipe.cookmethods.create!(user_id: current_user.id, method: cm)
        if cm!=""
          @cookmethod.save
        else
          @cookmethod.delete
        end
        
      end
      
      # ---------結果を出力----------#
      
      redirect_to recipes_path, success:"レシピを投稿しました！"
      
    else
      
      flash.now[:danger]="レシピの投稿に失敗しました"
      render :new
      
    end
    
  end
  




  # 投稿一覧
  def index
    @recipes=Recipe.all
    # binding pry
  end
  
  
  
  
  # # 投稿詳細
  def show
    # レシピをクリックしてレコードを取得する
      # binding pry
    @detail=Recipe.find_by(id: params[:id])
  
    # @detailにあるuser_idとrecipe_idを用いて「材料名」と「分量」の情報を抽出する
    @detail_material=Material.where(user_id: @detail.user_id, recipe_id: @detail.id)
    
    # @detailにあるuser_idとrecipe_idを用いて「作り��」の情報を抽出する
    @detail_method=Cookmethod.where(user_id: @detail.user_id, recipe_id: @detail.id)
    
    # @detailにあるuser_idを用いて「User」の情報を抽出する
    
    @n =  @detail_material.length/ 2
    @m =  @detail_method.length
    @user=User.find_by(id: @detail.user_id)
    # binding pry
  end
  
  
  def edit
    @recipe=Recipe.find_by(id: params[:id])
    @material=Material.where(user_id: @recipe.user_id, recipe_id: @recipe.id)
    @cookmethod=Cookmethod.where(user_id: @recipe.user_id, recipe_id: @recipe.id)
  end
    
    
    
  def update
     @update_recipe=Recipe.find_by(id: params[:id])
     @update_user_id=@update_recipe.user_id
      
    # binding pry
     @material=Material.where(user_id: @update_user_id , recipe_id: params[:id])
     @cookmethod=Cookmethod.where(user_id: @update_user_id, recipe_id: params[:id])
      # if true then
      #   logger.debug("if文の中に入りました")
      #   logger.debug(@update_user_id.inspect)
        # logger.debug(@update_recipe.user_id.inspect)
        # binding pry
        
        # @update_recipe.update_attributes(recipe_params)
        # binding pry
        @update_recipe.update(user_id: recipe_params[:user_id],title: recipe_params[:title],point: recipe_params[:point],image: recipe_params[:image],impression: recipe_params[:impression])
        
        @m_length=0
        @m_lengths=recipe_params[:materials_attributes]["0"][:material_name][0].length
        
        for m_length in 0..@m_lengths do
          # recipe_params[:materials_attributes][m_length.to_s]["material_name"].zip(recipe_params[:materials_attributes][m_length.to_s]["material_quantity"]).each do |m_name,m_quantity| 
          logger.debug(@m_lengths)
          
          @m_name=recipe_params[:materials_attributes][m_length.to_s]["material_name"][0]
          @m_quantity=recipe_params[:materials_attributes][m_length.to_s]["material_quantity"][0]
          
          if @m_name!="" && @m_quantity!=""
           
            # @m_.update_attributes(user_id: @update_user_id, material_name: m_name, material_quantity: m_quantity)
            @material.update(material_name: @m_name)
            @material.update(material_quantity: @m_quantity)
        
          elsif (m_name=="" && m_quantity!="") || (m_name!="" && m_quantity=="")
            # @m_recipe.update_attributes(user_id: @update_user_id, material_name: m_name, material_quantity: m_quantity)
            @material.update(m_name)
            @material.update(m_quantity)
            
          else
            flash.now[:danger]="投稿の編集に失敗しました"
            render :edit
          end
          
          
        logger.debug(@m_name)
        logger.debug(@m_quantity)
        end
        
        binding pry
        
        for method_length in 0..@lengths do
          recipe_params[:cookmethods_attributes][method_length.to_s]["method"].each do |cm|
          
          @update_recie=@update_recipe.cookmethods.update(user_id: @update_user_id, method: cm)
            if cm!=""
              @cookmethod.update(user_id: @update_user_id, method: cm)
            else
              flash.now[:danger]="投稿の編集に失敗しました"
              render :edit
            end
          end
        end
                
        
        
        
        
        
        
     
      
      redirect_to recipes_path, success:"投稿内容の編集をしました"
    
    # else
      # flash.now[:danger]="投稿の編集に失敗しました"
      # render :edit
    # end
  end
    
  
  
  private
  
 
  
  # def recipe_params
  #   params.require(:recipe).permit(:title, :point, :image, :impression,materials_attributes: [:material_name,:material_quantity],cookmethods_attributes: [:method])
  # end
  
  def recipe_params
    params.require(:recipe).permit(:title, :point, :image, :impression,materials_attributes: [:id,material_name: [],material_quantity: []],cookmethods_attributes: [:id,method: []])
  end
  
  
  
  
  
end
