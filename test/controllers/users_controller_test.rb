require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { cpf: "55566677788", name: "Novo Usuário", birth: "1995-06-10" }
    end

    assert_redirected_to users_path
  end

  test "should not create user with CPF duplicado" do
    assert_no_difference('User.count') do
      post :create, user: { cpf: @user.cpf, name: "Outro Nome", birth: "1990-01-01" }
    end

    assert_response :success
    assert assigns(:user).errors[:cpf].any?
  end

  test "should not create user with CPF com letras" do
    assert_no_difference('User.count') do
      post :create, user: { cpf: "123ABC78901", name: "Teste", birth: "1990-01-01" }
    end

    assert_response :success
    assert assigns(:user).errors[:cpf].any?
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { cpf: @user.cpf, name: @user.name, birth: @user.birth }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
