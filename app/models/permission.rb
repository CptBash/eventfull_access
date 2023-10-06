class Permission < ApplicationRecord
    belongs_to :user

    validates :user_id, presence: true

    def self.get_user_permissions(user_id)
        Permission.where(user_id: user_id).map { |p| p.role.name }
    end

    private

    # TODO: Move to an initializer or config file for scalability
    def permissions 
       permissions = ['admin', 'super_admin', 'user'].freeze
    end

    def is_admin?
        self.permissions.include?(self.role.name)
    end

    def is_super_admin?
        self.permissions.include?(self.role.name)
    end

    def is_user?
        self.permissions.include?(self.role.name)
    end
end
