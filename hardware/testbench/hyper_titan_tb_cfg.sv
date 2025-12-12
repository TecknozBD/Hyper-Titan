config hyper_titan_tb_cfg;

    design work.hyper_titan_tb;

    default liblist work;

    instance hyper_titan_tb.u_e_core liblist rvvcoreminiaxi;
    instance hyper_titan_tb.u_p_core liblist ariane;

endconfig
