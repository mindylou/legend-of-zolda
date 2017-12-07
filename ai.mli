open Types

(* [makeAiCommand st ai_id] is the command that the ai with id ai_id will make with 
 * the current state st *)
val makeAiCommand : state -> id -> command
