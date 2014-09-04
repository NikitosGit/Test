class ItemsController < ApplicationController
	
def index	
	@items = Item.all
	render "items/index" # рендер можно не указывать. 
						 #По умолчанию рендерится шаблон, совпадающий с названием метода т. е. index.html.erb
	
	#render text: @items.map {|i| "#{i.id} #{i.name}: #{i.price}"}.join("<br/>")
end

#url /items/1 GET
def show
	unless @item = Item.where(id: params[:id]).first #@item = Item.find(params[:id]) - сам придумал :) вроде работает
		render text: "Page not found", status: 404
	end
end

#url /items/new GET
def new
	@item = Item.new
end

#url /items/1/edit GET
def edit
end

#url /items POST
def create
	#@item = Item.create(name: params[:name], description: params[:description], price: 
	#	params[:price], real: params[:real], weight: params[:weight])
	

#	@item = Item.create(item_params)		
	@item = Item.create(item_params)
	if @item.errors.empty?
		redirect_to item_path(@item)	
	else
		render "new"
	end	
#	p params
#	render text: "#{@item.id}: #{@item.name} #{@item.price} (#{!@item.new_record?})"

#	render text: params.inspect
end

#url /items/1 PUT
def update
end

#url /items/1 DELETE
def destroy
end

private 
	
def item_params
	params.require(:item).permit(:name, :description, :price, :weight, :real)
end

end
