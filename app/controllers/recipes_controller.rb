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
    params.require(:recipe).permit(:title, :point, :image, :impression,materials_attributes: {material_name: [],material_quantity: []},cookmethods_attributes: {method: []})
  end

  
end
