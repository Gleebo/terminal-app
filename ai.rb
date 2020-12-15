module AI
  def AI.enemy_turn(game, id)
    enemy = game.current_room.enemies[id]
    
    if enemy.attack_skill && enemy.attack_skill[:cd] == 0
      return enemy.use_attack_skill(game.player)
    end
    
    if enemy.defense_skill &&
        enemy.defense_skill[:cd] == 0 &&
        game.current_room.get_wounded_id
      return enemy.use_defense_skill(game.current_room.get_wounded_id)
    end

    return enemy.attack(game.player)
  end
end