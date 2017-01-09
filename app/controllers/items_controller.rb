class ItemsController < ApplicationController
  def new
    @item = Item.new
    render :new
  end

  def create
    item = current_user.items.new(item_params)

    if item.save
      flash[:notice] = "Item \"#{item.name}\" was created successfully"
      redirect_to "/"
    else
      @item = item
      flash[:errors] = item.errors.full_messages
      render :new
    end
  end

  def index
    @items = current_user.items
    render "user_items"
  end

  def edit
    @item = current_user.items.find_by(id: params[:id])

    if @item
      render :edit
    else
      flash[:error] = "Item not found"
      redirect_to "/"
    end
  end

  def update
    item = current_user.items.find_by(params[:id])

    if item.update(item_params)
      flash[:success] = "The item details have been saved"
      redirect_to user_items_path(current_user)
    else
      @item = item
      flash[:errors] = item.errors.full_messages
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category)
  end
end
