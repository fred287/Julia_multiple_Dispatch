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

const no_effect = 0
const not_very_effective = 0.5
const normal_effective = 1
const super_effective = 2

eff(atk::P1, def::P2) where {P1 <: AbstractType, P2 <: AbstractType} = normal_effective
eff(atk::Normal,   def)           = normal_effective             
eff(atk::Fire,     def::Grass)    = super_effective
eff(atk::Fire,     def::Ice)      = super_effective
eff(atk::Water,     def::Fire)    = super_effective
eff(atk::Water,    def::Ground)   = super_effective
eff(atk::Electric, def::Water)    = super_effective
eff(atk::Grass,    def::Water)    = super_effective
eff(atk::Grass,    def::Ground)   = super_effective
eff(atk::Ice,      def::Grass)    = super_effective
eff(atk::Ice,      def::Ground)   = super_effective
eff(atk::Fighting, def::Normal)   = super_effective
eff(atk::Fighting, def::Ice)      = super_effective
eff(atk::Poison,   def::Grass)    = super_effective
eff(atk::Ground,   def::Fire)     = super_effective
eff(atk::Ground,   def::Electric) = super_effective
eff(atk::Ground,   def::Poison)   = super_effective

eff(atk::Fire,     def::Water)  = not_very_effective
eff(atk::Water,    def::Grass)  = not_very_effective
eff(atk::Electric, def::Grass)  = not_very_effective
eff(atk::Grass,    def::Fire)   = not_very_effective
eff(atk::Grass,    def::Poison) = not_very_effective
eff(atk::Ice,      def::Fire)   = not_very_effective
eff(atk::Ice,      def::Water)  = not_very_effective
eff(atk::Fighting, def::Poison) = not_very_effective
eff(atk::Poison,   def::Ground) = not_very_effective
eff(atk::Ground,   def::Grass)  = not_very_effective

eff(atk::P1, def::P2) where {P1,P2 <: AbstractType} = not_very_effective
eff(atk::Fighting, def::Fighting)                   = normal_effective
eff(atk::Ground,   def::Ground)                     = normal_effective

eff(atk::Electric,   def::Ground)                   = no_effect

function eff_string(effectiveness)
    if effectiveness == no_effect
        return "without any effect"
    elseif effectiveness == not_very_effective
        return "not very effective"
    elseif effectiveness == normal_effective
        return "normally effective"
    elseif effectiveness == super_effective
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