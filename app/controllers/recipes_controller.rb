class RecipesController < ApplicationController
  
  protect_from_forgery except: :create
  
  # 新規投稿
  def new
    @recipe=Recipe.new
    @material=@recipe.materials.build(material_params)
    
  end
  
  
  # 新規作成
  def create
    # binding pry
    # レシピと材料のオブジェクトを作成
    @recipe=Recipe.new(recipe_params)
    binding pry
    # binding.pry
    # @material=Material.new(material_params)
    
    # ---------必要な情報を格納----------#
        
    # @recipe、@materialにuser_idを格納
    @recipe.user_id=current_user.id
    # @material.user_id=current_user.id
    @recipe.save
    # @materialにrecipe_idを格納
    
    @material.recipe_id=@recipe.id
    
    # @materialsに材料名と分量を格納 => ひとつずつ取り出して保存する？
  
    # @material.material_name=material_params[:material_name]
    # @material.material_quantity=material_params[:material_quantity]
  
    # 配列で格納されているので添字の数を把握
    
    # material_name_cnt=@material.material_name.size
    # material_quantity_cnt=@material.material_quantity.size
    
    # 材料名と分量は配列で格納されているのでひとつずつ取り出して保存
    
    material_params[:material_name].zip(material_params[:material_quantity]).each do |m_name,m_quantity|
      
      
      @material.material_name=m_name
      @material.material_quantity=m_quantity
      
      
      @material.material_name.save
      @material.material_quantity.save
      
    end
    
   # ---------格納した情報をテーブルに保存----------#

    
    if @recipe.save && @material.material_name.save && @material.material_quantity.save
      redirect_to recipes_index_path, success:"レシピを投稿しました！"
    else
      flash.now[:danger]="レシピの投稿に失敗しました"
      render :new
    end
    
  end
  
  
  
  # 投稿一覧
  def index
    # @recipes=Recipes.all.order(created_at: :desc)
  end
  
  
  # 投稿詳細
  def show
    # @detail=Recipe.find_by(id: params[:id])
    # @user=User.find_by(id: @detail.user_id)
  end
  
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :point, :image, :impression,material_attributes:[:material_name,:material_quantity])
  end

  
end
