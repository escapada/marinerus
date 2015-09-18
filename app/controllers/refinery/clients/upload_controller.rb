module Refinery
	module Clients
		class UploadController < ::ApplicationController#::ActionController::Base 

			def create_file
				@fileholder = Refinery::Ships::Doc.create(params[:doc])
			end

			def create_photo
				@photoholder = Refinery::Ships::Photo.create(params[:photo])
			end

			def delete_photo
				@id = params[:id]
				@photoholder = Refinery::Ships::Photo.find(params[:id])
				@photoholder.photo = nil
				@photoholder.destroy

				render :text => "Deleted #{params[:id]}"
			end

			def delete_file
				@id = params[:id]
				@fileholder = Refinery::Ships::Doc.find(params[:id])
				@fileholder.doc = nil
				@fileholder.destroy

				render :text => "Deleted #{params[:id]}"
			end
		end
	end
end