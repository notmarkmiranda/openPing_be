module Api
  module V1
    class SitesController < ApplicationController
      before_action :authenticate_user
      before_action :set_site, only: [ :show, :update, :destroy ]

      def index
        @sites = current_user.sites
        render json: @sites
      end

      def show
        render json: @site
      end

      def create
        @site = current_user.sites.build(site_params)
        if @site.save
          render json: @site, status: :created
        else
          render json: @site.errors, status: :unprocessable_entity
        end
      end

      def update
        @site = Site.find(params[:id])
        if @site.update(site_params)
          render json: @site, status: :ok
        else
          render json: @site.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @site.destroy
        head :no_content
      end

      private

      def set_site
        @site = current_user.sites.find(params[:id])
      end

      def site_params
        params.require(:site).permit(:url, :frequency, :is_active)
      end
    end
  end
end
