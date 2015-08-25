module Refinery
	module Clients
		class UploadController < ::ApplicationController#::ActionController::Base 

			def create_file
				@fileholder = Refinery::Ships::File.create(params[:file])
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
				@fileholder = Refinery::Ships::File.find(params[:id])
				@fileholder.file = nil
				@fileholder.destroy

				render :text => "Deleted #{params[:id]}"
			end
		end
	end
end