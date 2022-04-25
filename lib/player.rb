class Player 
  attr_accessor :name, :life_points

  def initialize(name, life_points = 10)
    @name = name
    @life_points = life_points
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage_received)
    @life_points -= damage_received
    puts "le joueur #{@name} a été tué !" if @life_points <= 0
  end

  def attacks(player_under_attack)
    puts "le joueur #{@name} attaque le joueur #{player_under_attack.name}"
    attack_damage = compute_damage 
    puts "il lui inflige #{attack_damage} points de dommages"
    player_under_attack.gets_damage(attack_damage)
  end

  def compute_damage
    return rand(1..6)
  end

end