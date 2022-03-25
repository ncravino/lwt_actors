

let rec actor1 mbox_in mbox_out = 
    let%lwt msg = Lwt_mvar.take mbox_in in
    let res = msg + 1  in
    let _ = Lwt_mvar.put mbox_out (string_of_int res) 
    in actor1 mbox_in mbox_out



let rec actor2 mbox_in = 
    let%lwt msg = Lwt_mvar.take mbox_in in
    let () = print_endline msg in 
    actor2 mbox_in

let main = 
 let mbox_1 = Lwt_mvar.create_empty () in
 let mbox_2 = Lwt_mvar.create_empty () in
 let _a1 = actor1 mbox_1 mbox_2 in
 let _a2 = actor2 mbox_2 in
 Lwt_list.iter_p (fun x -> Lwt_mvar.put mbox_1 x)  [1;2;3]



let () =  
    Lwt_main.run main 
