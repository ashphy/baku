server = Server.create(host: 'irc.livedoor.ne.jp', encoding: 'iso-2022-jp')
Channel.create(name:'#pd2013', server_id: server.id)