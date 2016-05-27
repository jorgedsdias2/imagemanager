# -*- encoding : utf-8 -*-
if User.count == 0
	User.create(name: 'Administrador', email: 'admin@email.com.br', password: '123456', password_confirmation: '123456')
end