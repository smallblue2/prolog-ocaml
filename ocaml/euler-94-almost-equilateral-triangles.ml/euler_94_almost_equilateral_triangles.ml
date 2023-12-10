let validateCmdLine =
  if Array.length Sys.argv == 2 then
    match int_of_string_opt Sys.argv.(1) with
    | Some num -> (true, num)
    | None -> (false, -1)
    else
      (false, -1)

let isPerfectSquare x =
  if x < 0 then false
  else
    let root = int_of_float (sqrt (float_of_int x)) in
    root * root = x

let integralArea x delta =
  let formula = (4 * x * x) - ((x + delta) * (x + delta))
  in isPerfectSquare formula

let rec sum_perimeters i limit total =
  if (3 * i + 1) >= limit && (3 * i - 1) >= limit then
    total
  else
    let total = if integralArea i 1 then total + (3 * i + 1) else total in
    let total = if integralArea i (-1) then total + (3 * i - 1) else total in
    sum_perimeters (i + 1) limit total

let total_sum limit =
  sum_perimeters 2 limit 0


let () =
  let (validity, num) = validateCmdLine
  in if validity then Printf.printf "%d\n" (total_sum num)
  else Printf.printf "Invalid argument!\n"

