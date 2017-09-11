class Pin < ApplicationRecord
	validates :title, presence:true
	validates :description, presence:true
   	PHOTOS_FOLDER = File.join Rails.root, 'public', 'photo_storage' 
	belongs_to :user

	after_save :guarda_foto

	def pin_params
      params.require(:pin).permit(:photo, :title, :description)
    end


	def photo=(file_data)
		unless file_data.blank?
			@file_data = file_data
			self.extension = file_data.original_filename.split('.').last.downcase
		end
	end

	def photo_filename
		File.join PHOTOS_FOLDER, "#{id}.#{extension}"
	end

	def photo_path
		"/photo_storage/#{id}.#{extension}"
	end

	private

	def guarda_foto
		if @file_data
			FileUtils.mkdir_p PHOTOS_FOLDER
			File.open(photo_filename, 'wb') do |f|
				f.write(@file_data.read)
			end
			@file_data = nil
		end
	end

end
