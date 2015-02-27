class Listing < ActiveRecord::Base

    if Rails.env.development?
        has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>"  }, :default_url => "default-placeholder.png"
        validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    else 
        has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>"  }, :default_url => "default-placeholder.png",
                          :storage => :dropbox,
                          :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                          :dropbox_options => {},
                          :path => ":style/:id_filename"
        validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    end

    validates :name, :description, :price, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates_attachment_presence :image
end
