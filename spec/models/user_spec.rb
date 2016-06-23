require 'rails_helper'
RSpec.describe User do
  # ...
  describe 'relationships' do
    it 'has many secrets' do
      user = create_user
      secret1 = user.secrets.create(content: 'secret 1')
      secret2 = user.secrets.create(content: 'secret 2')
      expect(user.secrets).to include(secret1)
      expect(user.secrets).to include(secret2)
    end
    it 'has many likes' do
      user = create_user
      secret1 = user.secrets.create(content: 'Oops')
      secret2 = user.secrets.create(content: 'I did it again')
      like1 = Like.create(user: user, secret: secret1)
      like2 = Like.create(user: user, secret: secret2)
      expect(user.likes).to include(like1)
      expect(user.likes).to include(like2)
    end
  end
end
