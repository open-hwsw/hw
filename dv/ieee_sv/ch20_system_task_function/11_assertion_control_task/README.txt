assert_control_task ::= 
    assert_task [ ( levels [ , list_of_scopes_or_assertions ] ) ] ; 
  | assert_action_task [ ( levels [ , list_of_scopes_or_assertions ] ) ] ; 
  | $assertcontrol ( control_type [ , [ assertion_type ] [ , [ directive_type ] [ , [ levels ] 
  [ , list_of_scopes_or_assertions ] ] ] ] ) ; 

assert_task ::=
    $asserton 
  | $assertoff 
  | $assertkill 

assert_action_task ::= 
    $assertpasson 
  | $assertpassoff 
  | $assertfailon 
  | $assertfailoff 
  | $assertnonvacuouson 
  | $assertvacuousoff 

list_of_scopes_or_assertions ::= scope_or_assertion { , scope_or_assertion }
scope_or_assertion ::= hierarchical_identifier 
