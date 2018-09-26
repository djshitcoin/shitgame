desc "spawn mobs"
task spawner: [:environment] do
  adjectives = ['bankrupt', 'idiot', 'slimy', 'crazy', 'cross-eyed', 'smelly', 'FUD-spreading', '', '', '', '', '', '', '','','','','','','','']
  names = ['Bitconnect promoter', 'Satoshi hater', 'Zombie', 'Pirate', 'Script kiddy', '"Blockchain engineer"', '"Blockchain expert"', 'Goblin', 'Skellington', 'DJ']
  postfixes = ['with weak hands', 'who sold everything', 'of SwissBorg', 'full of FUD', '', '', '', '','','','','','','','','']
  while true
    if Entity.where(hodler_id: nil).count < 3 && Random.rand > 0.9
      name = [adjectives.sample, names.sample, postfixes.sample].join(' ').strip
      e = Entity.create!(name: name, stats: {
        constitution: Random.rand(4),
        exp: 0
      })
      puts "spawned entity #{e.id}"
    end
    sleep 1
  end
end