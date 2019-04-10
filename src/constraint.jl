mutable struct ConstrData <: AbstractVarConstrData
    rhs::Float64 
    kind::ConstrKind
    sense::ConstrSense
    is_active::Bool
end
ConstrData() = ConstrData(Inf, Core, Less, true)

mutable struct MoiConstrRecord
    index::MoiConstrIndex
end
MoiConstrRecord() = MoiConstrRecord(MoiConstrIndex())

struct Constraint <: AbstractVarConstr
    id::Id{Constraint}
    name::String
    duty::Type{<: AbstractConstrDuty}
    initial_state::ConstrData
    cur_state::ConstrData
    moi_record::MoiConstrRecord
end
Constraint() = Constraint(Id{Constraint}(), "", UndefinedConstrDuty,
                          ConstrData(), ConstrData(), MoiConstrRecord())

getid(vc::AbstractVarConstr) = vc.id
getuid(vc::AbstractVarConstr) = getuid(vc.id)
getname(vc::AbstractVarConstr) = vc.name
getduty(vc::AbstractVarConstr) = vc.duty
get_initial_state(vc::AbstractVarConstr) = vc.initial_state
get_cur_state(vc::AbstractVarConstr) = vc.cor_state
get_moi_record(vc::AbstractVarConstr) = vc.moi_record



###################################################################

# function type_of_moi_set(sense::ConstrSense)
#     sense == Greater && return MOI.GreaterThan{Float64}
#     sense == Less && return MOI.LessThan{Float64}
#     sense == Equal && return MOI.EqualTo{Float64}
# end

# function Constraint(name::String)
#     return Constraint(0, name, 0.0, Greater, Core)
# end

# getform(c::Constraint) = c.form_uid
# getname(c::Constraint) = c.name
# getrhs(c::Constraint) = c.rhs
# getsense(c::Constraint) = c.sense
# getkind(c::Constraint) = c.kind

# setform!(c::Constraint, uid::FormId) = c.form_uid = uid
# setname!(c::Constraint, name::String) = c.name = name
# setrhs!(c::Constraint, r::Float64) = c.rhs = r
# setsense!(c::Constraint, s::ConstrSense) = c.sense = s
# setkind!(c::Constraint, t::ConstrKind) = c.kind = t

# function set!(c::Constraint, s::MOI.GreaterThan)
#     rhs = float(s.lower)
#     setsense!(c, Greater)
#     setrhs!(c, rhs)
#     return
# end

# function set!(c::Constraint, s::MOI.EqualTo)
#     rhs = float(s.value)
#     setsense!(c, Equal)
#     setrhs!(c, rhs)
#     return
# end

# function set!(c::Constraint, s::MOI.LessThan)
#     rhs = float(s.upper)
#     setsense!(c, Less)
#     setrhs!(c, rhs)
#     return
# end

# mutable struct ConstrState <: AbstractState
#     cur_rhs::Float64 
#     cur_sense::ConstrSense # Greater Less Equal
#     cur_status::Status   # Active or not
#     index::MoiConstrIndex # -> moi_index
#     set_type::MoiSetType
#     duty::DataType
# end
# ConstrState() = ConstrState(0.0, Greater, Active, MoiConstrIndex(), nothing, UndefinedConstrDuty)

# function ConstrState(Duty::Type{<: AbstractConstrDuty},
#                     constr::Constraint)
#     return ConstrState(getrhs(constr), getsense(constr), Active, MoiConstrIndex(), nothing, Duty)
# end

# getrhs(c::ConstrState) = c.cur_rhs
# getsense(c::ConstrState) = c.cur_sense
# getstatus(c::ConstrState) = c.cur_status
# getmoi_index(c::ConstrState) = c.index
# getduty(c::ConstrState) = c.duty
# getmoi_set(c::ConstrState) = type_of_moi_set(getsense(c))(getrhs(c))

# setrhs!(c::ConstrState, rhs::Float64) = c.cur_rhs = rhs
# setsense!(c::ConstrState, s::ConstrSense) = c.cur_sense = s
# setstatus!(c::ConstrState, s::Status) = c.cur_status = s
# setmoi_index!(c::ConstrState, index::MoiConstrIndex) = c.index = index
# # TODO :

# vctype(::Type{<: ConstrState}) = Constraint
# statetype(::Type{<: Constraint}) = ConstrState

# indextype(::Type{Constraint}) = MoiConstrIndex
# idtype(::Type{Constraint}) = Id{ConstrState}


# #setduty!(c::Constraint, d::ConstrDuty) = c.duty = d
