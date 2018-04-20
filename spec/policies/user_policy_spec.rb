RSpec.describe UserPolicy do
  permissions :index? do
    it 'denies access if user is not an admin' do
      expect(UserPolicy).not_to permit(User.new(admin: false))
    end

    it 'grants access if user is an admin' do
      expect(UserPolicy).to permit(User.new(admin: true))
    end
  end
end