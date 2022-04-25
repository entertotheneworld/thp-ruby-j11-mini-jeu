class Player 
  attr_accessor :name, :life_points

  def initialize(name, life_points = 10)
    @name = name
    @life_points = life_points
  end

  def show_state
    "#{@name} a #{@life_points} points de vie"
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

class HumanPlayer < Player 
  attr_accessor :weapon_level

  def initialize(name, life_points = 100, weapon_level = 1)
    @weapon_level = weapon_level
    super(name, life_points)
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    weapon_found = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{weapon_found}"
    if weapon_found > @weapon_level
      @weapon_level = weapon_found
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else 
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    health_pack_found = rand(1..6)
    if health_pack_found == 1
      puts "Tu n'as rien trouvé... "
    elsif health_pack_found >= 2 && health_pack_found <= 5
      @life_points += 50
      @life_points = 100 if @life_points > 100
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    else 
      @life_points += 80
      @life_points = 100 if @life_points > 100
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

end