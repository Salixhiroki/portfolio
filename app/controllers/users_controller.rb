# frozen_string_literal: true

class UsersController < ApplicationController
  # ユーザーアカウント作成ページへ遷移
  def new
    @user = User.new
  end

  # ユーザーアカウントを新規登録
  def create
    # binding pry
    @user = User.new(user_params)

    # binding pry

    if @user.save
      redirect_to login_path, success: 'アカウントの登録に成功しました'
    else
      flash.now[:danger] = 'アカウントの登録に失敗しました'
      render :new
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      redirect_to root_path, success: 'アカウントを削除しました'
    else
      flash.now[:danger] = 'アカウントの削除に失敗しました'
      render :destroy
    end
  end

  def index
    @user_recipes = Recipe.where(user_id: current_user.id)
    @q = Material.ransack(params[:q])

    @@q_materials = @q.result(distinct: true)
    @user_materials = @@q_materials.where(user_id: current_user.id)
  end

  # レシピ検索
  def search
    @q = Material.ransack(params[:q])
    # binding pry
    if search_params[:material_name_cont] != '' && @q.result(distinct: true) != nil
      # binding pry
      @materials_q = @q.result(distinct: true)
      @@q_materials = @q.result(distinct: true)
      @user_materials = @@q_materials.where(user_id: current_user.id)
      # binding pry
      if @user_materials != []
        i = 0
        @recipe_id = []
        @recipes_q = []
        @user_results = []
        # binding pry
        @user_materials.each do |material_q|
          logger.debug(material_q.recipe_id)
          @recipe_id[i] = material_q.recipe_id
          @recipes_q[i] = Recipe.where(id: material_q.recipe_id)
          # binding pry
          i += 1
        end
        @q_size = i - 1
      else
        @nothing = 1
        render :search
      end

    else
      @nothing = 1
      render :search
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    # @user.name=user_params[:name]
    # @user.email=user_params[:email]
    # @user.user_image=user_params[:user_image]
    # binding pry
    if @user.id == current_user.id
      if @user.update(user_params)
        redirect_to users_path, success: 'アカウントを編集しました'
      else
        flash.now[:danger] = 'アカウントを編集できませんでした'
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  # Strong Parameter
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_image)
  end

  def search_params
    params.require(:q).permit(:material_name_cont)
  end
end
