(* convert a number into a list of its digits *)
let build_list num =
  let rec aux n acc =
    if n = 0 then acc 
    else aux (n / 10) (n mod 10 :: acc)
  in aux num []

(* check if the number is increasing *)
let rec is_increasing = function
  | [] | [_] -> true
  | x :: (y :: _ as t) -> x <= y && is_increasing t

(* check if the number is decreasing *)
let rec is_decreasing = function
  | [] | [_] -> true
  | x :: (y :: _ as t) -> x >= y && is_decreasing t

(* check if a number is bouncy *)
let is_bouncy num =
  let num_list = build_list num in
  not (is_increasing num_list || is_decreasing num_list)

(* count the number of bouncy numbers and compare with target percentage *)
let bouncy_counter target_percentage =
  let rec aux num count =
    if is_bouncy num then
      let new_count = count + 1 in (* increment count if we found a bouncy number *)
      let ratio = (new_count * 100) / num in (* calc new ratio*)
      if ratio >= target_percentage then num (* return n if we reach the target *)
      else aux (num + 1) new_count
    else
      aux (num + 1) count (* if num is not bouncy *)
  in aux 100 0 (* can't have a bouncy number under 100 *)

(* "main" where we print and take in args *)
let () =
    (* if we don't have correct no cmdline args *)
    if Array.length Sys.argv <> 2 then
      Printf.printf "Usage: ./euler_112_bouncy_numbers <target>\n"
    else
      try
        let target = int_of_string Sys.argv.(1) in  (* Parse as integer *)
        if target > 100 || target < 0 then 
          Printf.printf "Invalid percentage given: %d\n" target
        else
          let result = bouncy_counter target in
          Printf.printf "%d\n" result
      with (* error handling *)
      | Failure _ -> Printf.printf "Invalid integer\n"
      | _ -> Printf.printf "Random error\n"