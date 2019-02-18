module Spree
  module Admin
    class ProductPackagesController < ResourceController
      before_action :load_data
      before_filter :load_data

      def create
        @object.attributes = permitted_resource_params
        @object.product_id=@product.id
        byebug
        if @object.save
          invoke_callbacks(:create, :after)
          flash[:success] = flash_message_for(@object, :successfully_created)
         redirect_to "/admin/products/#{@product.slug}/product_packages"
        else
          render "new"
          
        end
      end

      def update
        invoke_callbacks(:update, :before)
        if @object.update_attributes(permitted_resource_params)
          redirect_to "/admin/products/#{@object.product.slug}/product_packages"
        else
          redirect_to 'edit'
        end
        
      end

    
      

      private
        def load_data
          @product = Product.find_by(slug: params[:product_id])
        end

        def permitted_product_package_attributes
          [:length, :width, :height, :weight]
        end
    end
  end
end
