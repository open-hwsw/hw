module automatic tb;
    
    byte a, b, x;
    int hit [byte];
    int unsigned sum_of_all_weights;

    initial begin
        
        std::randomize(a,b);

        $display("the precision is %0d", $bits( unsigned'(a + b) + unsigned'(a - b) + unsigned'(a ^ ~b) + unsigned'(12'h800) ));

        sum_of_all_weights = unsigned'(a + b) + unsigned'(a - b) + unsigned'(a ^ ~b) + unsigned'(12'h800);
        
        repeat(sum_of_all_weights)begin
            
            randcase
                a + b   : x = 1;
                a - b   : x = 2;
                a ^ ~b  : x = 3;
                12'h800 : x = 4;
            endcase
            
            hit[x]++;

        end

        $display("the expected probability of taking the first branch = %f, and actual probability = %f" , real'(unsigned'(a + b)) / real'(sum_of_all_weights)  , real'(hit[1]) / real'(sum_of_all_weights));
        $display("the expected probability of taking the second branch = %f, and actual probability = %f", real'(unsigned'(a - b)) / real'(sum_of_all_weights)  , real'(hit[2]) / real'(sum_of_all_weights));
        $display("the expected probability of taking the third branch = %f and actual probability = %f"  , real'(unsigned'(a ^ ~b)) / real'(sum_of_all_weights) , real'(hit[3]) / real'(sum_of_all_weights));
        $display("the expected probability of taking the fourth branch = %f and actual probability = %f" , real'(unsigned'(12'h800)) / real'(sum_of_all_weights), real'(hit[4]) / real'(sum_of_all_weights));

    end

endmodule : tb