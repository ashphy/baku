# frozen_string_literal: true
server = Server.create(host: 'localhost', encoding: 'iso-2022-jp')
Channel.create(name: '#pd2013', server_id: server.id)
