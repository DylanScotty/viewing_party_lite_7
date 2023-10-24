class User < ApplicationRecord 
    has_many :party_guests
    has_many :viewing_parties, through: :party_guests
    
    validates_presence_of :name, presence: true
    validates :email, uniqueness: {case_sensetive: false}, presence: true
    validates :password, presence: true, confirmation: true
    has_secure_password


    def invited_viewing_parties
        self.viewing_parties
    end
end