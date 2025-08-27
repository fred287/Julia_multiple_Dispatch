abstract type AbstractType end

struct Normal   <: AbstractType end
struct Fire     <: AbstractType end
struct Water    <: AbstractType end
struct Electric <: AbstractType end
struct Grass    <: AbstractType end
struct Ice      <: AbstractType end
struct Fighting <: AbstractType end
struct Poison   <: AbstractType end
struct Ground   <: AbstractType end

const No_effect = 0
const Not_very_effective = 0.5
const Normal_effective = 1
const Super_effective = 2

type_effectiveness = Dict(
    (Fire, Grass)     => Super_effective,
    (Fire, Ice)       => Super_effective,
    (Water, Fire)     => Super_effective,
    (Water, Ground)   => Super_effective,
    (Electric, Water) => Super_effective,
    (Grass, Water)    => Super_effective,
    (Grass, Ground)   => Super_effective,
    (Ice, Grass)      => Super_effective,
    (Ice, Ground)     => Super_effective,
    (Fighting, Normal) => Super_effective,
    (Fighting, Ice)   => Super_effective,
    (Poison, Grass)   => Super_effective,
    (Ground, Fire)    => Super_effective,
    (Ground, Electric) => Super_effective,
    (Ground, Poison)  => Super_effective,

    (Fire, Water)     => Not_very_effective,
    (Water, Grass)    => Not_very_effective,
    (Electric, Grass) => Not_very_effective,
    (Grass, Fire)     => Not_very_effective,
    (Grass, Poison)   => Not_very_effective,
    (Ice, Fire)       => Not_very_effective,
    (Ice, Water)      => Not_very_effective,
    (Fighting, Poison) => Not_very_effective,
    (Poison, Ground)  => Not_very_effective,
    (Ground, Grass)   => Not_very_effective,

    (Electric, Ground) => No_effect)

function default_effectiveness(atk::AbstractType, def::AbstractType)
    if typeof(atk) === Normal && typeof(def) === Normal
        return Normal_effective
    elseif typeof(atk) === typeof(def)
        return Not_very_effective
    else
        return Normal_effective
    end
end


function eff(atk::AbstractType, def::AbstractType)
    return get(type_effectiveness, (typeof(atk), typeof(def)),
               default_effectiveness(atk, def))
end

function eff_string(effectiveness)
    if effectiveness == No_effect
        return "without any effect"
    elseif effectiveness == Not_very_effective
        return "not very effective"
    elseif effectiveness == Normal_effective
        return "normally effective"
    elseif effectiveness == Super_effective
        return "super effective"
    else
        return "unknown effectiveness"
    end
end

function attack(atk, def)
    effectiveness = eff(atk, def)
    println("A Pokémon used a $(typeof(atk)) attack")
    println("against a $(typeof(def)) Pokémon.")
    println("It was $(eff_string(effectiveness)).")
end

# Example Usage
attack(Fire(), Grass())   
attack(Electric(), Ground())  
attack(Normal(), Normal()) # This should be normal effective
attack(Normal(), Fighting())
attack(Fighting(), Normal())