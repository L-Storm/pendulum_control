    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 5;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (QUARC_simlink_P)
        ;%
            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% QUARC_simlink_P.HILReadEncoder_channels
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_P.HILWriteAnalog_channels
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 15;
            section.data(15)  = dumData; %prealloc

                    ;% QUARC_simlink_P.HILInitialize_OOTerminate
                    section.data(1).logicalSrcIdx = 2;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_P.HILInitialize_OOExit
                    section.data(2).logicalSrcIdx = 3;
                    section.data(2).dtTransOffset = 1;

                    ;% QUARC_simlink_P.HILInitialize_OOStart
                    section.data(3).logicalSrcIdx = 4;
                    section.data(3).dtTransOffset = 2;

                    ;% QUARC_simlink_P.HILInitialize_OOEnter
                    section.data(4).logicalSrcIdx = 5;
                    section.data(4).dtTransOffset = 3;

                    ;% QUARC_simlink_P.HILInitialize_AOFinal
                    section.data(5).logicalSrcIdx = 6;
                    section.data(5).dtTransOffset = 4;

                    ;% QUARC_simlink_P.HILInitialize_POFinal
                    section.data(6).logicalSrcIdx = 7;
                    section.data(6).dtTransOffset = 5;

                    ;% QUARC_simlink_P.HILInitialize_AIHigh
                    section.data(7).logicalSrcIdx = 8;
                    section.data(7).dtTransOffset = 6;

                    ;% QUARC_simlink_P.HILInitialize_AILow
                    section.data(8).logicalSrcIdx = 9;
                    section.data(8).dtTransOffset = 7;

                    ;% QUARC_simlink_P.HILInitialize_AOHigh
                    section.data(9).logicalSrcIdx = 10;
                    section.data(9).dtTransOffset = 8;

                    ;% QUARC_simlink_P.HILInitialize_AOLow
                    section.data(10).logicalSrcIdx = 11;
                    section.data(10).dtTransOffset = 9;

                    ;% QUARC_simlink_P.HILInitialize_AOInitial
                    section.data(11).logicalSrcIdx = 12;
                    section.data(11).dtTransOffset = 10;

                    ;% QUARC_simlink_P.HILInitialize_POFrequency
                    section.data(12).logicalSrcIdx = 13;
                    section.data(12).dtTransOffset = 11;

                    ;% QUARC_simlink_P.HILInitialize_POInitial
                    section.data(13).logicalSrcIdx = 14;
                    section.data(13).dtTransOffset = 12;

                    ;% QUARC_simlink_P.Constant_Value
                    section.data(14).logicalSrcIdx = 15;
                    section.data(14).dtTransOffset = 13;

                    ;% QUARC_simlink_P.Gain_Gain
                    section.data(15).logicalSrcIdx = 16;
                    section.data(15).dtTransOffset = 14;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QUARC_simlink_P.HILInitialize_EIInitial
                    section.data(1).logicalSrcIdx = 17;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% QUARC_simlink_P.HILInitialize_EIChannels
                    section.data(1).logicalSrcIdx = 18;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_P.HILInitialize_EIQuadrature
                    section.data(2).logicalSrcIdx = 19;
                    section.data(2).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section

            section.nData     = 37;
            section.data(37)  = dumData; %prealloc

                    ;% QUARC_simlink_P.HILInitialize_Active
                    section.data(1).logicalSrcIdx = 20;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_P.HILInitialize_AOTerminate
                    section.data(2).logicalSrcIdx = 21;
                    section.data(2).dtTransOffset = 1;

                    ;% QUARC_simlink_P.HILInitialize_AOExit
                    section.data(3).logicalSrcIdx = 22;
                    section.data(3).dtTransOffset = 2;

                    ;% QUARC_simlink_P.HILInitialize_DOTerminate
                    section.data(4).logicalSrcIdx = 23;
                    section.data(4).dtTransOffset = 3;

                    ;% QUARC_simlink_P.HILInitialize_DOExit
                    section.data(5).logicalSrcIdx = 24;
                    section.data(5).dtTransOffset = 4;

                    ;% QUARC_simlink_P.HILInitialize_POTerminate
                    section.data(6).logicalSrcIdx = 25;
                    section.data(6).dtTransOffset = 5;

                    ;% QUARC_simlink_P.HILInitialize_POExit
                    section.data(7).logicalSrcIdx = 26;
                    section.data(7).dtTransOffset = 6;

                    ;% QUARC_simlink_P.HILInitialize_CKPStart
                    section.data(8).logicalSrcIdx = 27;
                    section.data(8).dtTransOffset = 7;

                    ;% QUARC_simlink_P.HILInitialize_CKPEnter
                    section.data(9).logicalSrcIdx = 28;
                    section.data(9).dtTransOffset = 8;

                    ;% QUARC_simlink_P.HILInitialize_CKStart
                    section.data(10).logicalSrcIdx = 29;
                    section.data(10).dtTransOffset = 9;

                    ;% QUARC_simlink_P.HILInitialize_CKEnter
                    section.data(11).logicalSrcIdx = 30;
                    section.data(11).dtTransOffset = 10;

                    ;% QUARC_simlink_P.HILInitialize_AIPStart
                    section.data(12).logicalSrcIdx = 31;
                    section.data(12).dtTransOffset = 11;

                    ;% QUARC_simlink_P.HILInitialize_AIPEnter
                    section.data(13).logicalSrcIdx = 32;
                    section.data(13).dtTransOffset = 12;

                    ;% QUARC_simlink_P.HILInitialize_AOPStart
                    section.data(14).logicalSrcIdx = 33;
                    section.data(14).dtTransOffset = 13;

                    ;% QUARC_simlink_P.HILInitialize_AOPEnter
                    section.data(15).logicalSrcIdx = 34;
                    section.data(15).dtTransOffset = 14;

                    ;% QUARC_simlink_P.HILInitialize_AOStart
                    section.data(16).logicalSrcIdx = 35;
                    section.data(16).dtTransOffset = 15;

                    ;% QUARC_simlink_P.HILInitialize_AOEnter
                    section.data(17).logicalSrcIdx = 36;
                    section.data(17).dtTransOffset = 16;

                    ;% QUARC_simlink_P.HILInitialize_AOReset
                    section.data(18).logicalSrcIdx = 37;
                    section.data(18).dtTransOffset = 17;

                    ;% QUARC_simlink_P.HILInitialize_DOPStart
                    section.data(19).logicalSrcIdx = 38;
                    section.data(19).dtTransOffset = 18;

                    ;% QUARC_simlink_P.HILInitialize_DOPEnter
                    section.data(20).logicalSrcIdx = 39;
                    section.data(20).dtTransOffset = 19;

                    ;% QUARC_simlink_P.HILInitialize_DOStart
                    section.data(21).logicalSrcIdx = 40;
                    section.data(21).dtTransOffset = 20;

                    ;% QUARC_simlink_P.HILInitialize_DOEnter
                    section.data(22).logicalSrcIdx = 41;
                    section.data(22).dtTransOffset = 21;

                    ;% QUARC_simlink_P.HILInitialize_DOReset
                    section.data(23).logicalSrcIdx = 42;
                    section.data(23).dtTransOffset = 22;

                    ;% QUARC_simlink_P.HILInitialize_EIPStart
                    section.data(24).logicalSrcIdx = 43;
                    section.data(24).dtTransOffset = 23;

                    ;% QUARC_simlink_P.HILInitialize_EIPEnter
                    section.data(25).logicalSrcIdx = 44;
                    section.data(25).dtTransOffset = 24;

                    ;% QUARC_simlink_P.HILInitialize_EIStart
                    section.data(26).logicalSrcIdx = 45;
                    section.data(26).dtTransOffset = 25;

                    ;% QUARC_simlink_P.HILInitialize_EIEnter
                    section.data(27).logicalSrcIdx = 46;
                    section.data(27).dtTransOffset = 26;

                    ;% QUARC_simlink_P.HILInitialize_POPStart
                    section.data(28).logicalSrcIdx = 47;
                    section.data(28).dtTransOffset = 27;

                    ;% QUARC_simlink_P.HILInitialize_POPEnter
                    section.data(29).logicalSrcIdx = 48;
                    section.data(29).dtTransOffset = 28;

                    ;% QUARC_simlink_P.HILInitialize_POStart
                    section.data(30).logicalSrcIdx = 49;
                    section.data(30).dtTransOffset = 29;

                    ;% QUARC_simlink_P.HILInitialize_POEnter
                    section.data(31).logicalSrcIdx = 50;
                    section.data(31).dtTransOffset = 30;

                    ;% QUARC_simlink_P.HILInitialize_POReset
                    section.data(32).logicalSrcIdx = 51;
                    section.data(32).dtTransOffset = 31;

                    ;% QUARC_simlink_P.HILInitialize_OOReset
                    section.data(33).logicalSrcIdx = 52;
                    section.data(33).dtTransOffset = 32;

                    ;% QUARC_simlink_P.HILInitialize_DOFinal
                    section.data(34).logicalSrcIdx = 53;
                    section.data(34).dtTransOffset = 33;

                    ;% QUARC_simlink_P.HILInitialize_DOInitial
                    section.data(35).logicalSrcIdx = 54;
                    section.data(35).dtTransOffset = 34;

                    ;% QUARC_simlink_P.HILReadEncoder_Active
                    section.data(36).logicalSrcIdx = 55;
                    section.data(36).dtTransOffset = 35;

                    ;% QUARC_simlink_P.HILWriteAnalog_Active
                    section.data(37).logicalSrcIdx = 56;
                    section.data(37).dtTransOffset = 36;

            nTotData = nTotData + section.nData;
            paramMap.sections(5) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (QUARC_simlink_B)
        ;%
            section.nData     = 7;
            section.data(7)  = dumData; %prealloc

                    ;% QUARC_simlink_B.HILReadEncoder_o1
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_B.HILReadEncoder_o2
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% QUARC_simlink_B.Add
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% QUARC_simlink_B.otpt_v
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% QUARC_simlink_B.P1
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 4;

                    ;% QUARC_simlink_B.P2
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 5;

                    ;% QUARC_simlink_B.otpt
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QUARC_simlink_B.status
                    section.data(1).logicalSrcIdx = 8;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 6;
        sectIdxOffset = 2;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (QUARC_simlink_DW)
        ;%
            section.nData     = 5;
            section.data(5)  = dumData; %prealloc

                    ;% QUARC_simlink_DW.HILInitialize_FilterFrequency
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_DW.previous_arm1_inpt
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 2;

                    ;% QUARC_simlink_DW.previous_arm2_inpt
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 3;

                    ;% QUARC_simlink_DW.i1
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 4;

                    ;% QUARC_simlink_DW.i2
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 5;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% QUARC_simlink_DW.HILInitialize_Card
                    section.data(1).logicalSrcIdx = 5;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section

            section.nData     = 9;
            section.data(9)  = dumData; %prealloc

                    ;% QUARC_simlink_DW.HILReadEncoder_PWORK
                    section.data(1).logicalSrcIdx = 6;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_DW.HILWriteAnalog_PWORK
                    section.data(2).logicalSrcIdx = 7;
                    section.data(2).dtTransOffset = 1;

                    ;% QUARC_simlink_DW.Scope_PWORK.LoggedData
                    section.data(3).logicalSrcIdx = 8;
                    section.data(3).dtTransOffset = 2;

                    ;% QUARC_simlink_DW.Scope1_PWORK.LoggedData
                    section.data(4).logicalSrcIdx = 9;
                    section.data(4).dtTransOffset = 4;

                    ;% QUARC_simlink_DW.Scope2_PWORK.LoggedData
                    section.data(5).logicalSrcIdx = 10;
                    section.data(5).dtTransOffset = 6;

                    ;% QUARC_simlink_DW.Status_PWORK.LoggedData
                    section.data(6).logicalSrcIdx = 11;
                    section.data(6).dtTransOffset = 8;

                    ;% QUARC_simlink_DW.alpha_PWORK.LoggedData
                    section.data(7).logicalSrcIdx = 12;
                    section.data(7).dtTransOffset = 9;

                    ;% QUARC_simlink_DW.ctrlV_PWORK.LoggedData
                    section.data(8).logicalSrcIdx = 13;
                    section.data(8).dtTransOffset = 10;

                    ;% QUARC_simlink_DW.theta_PWORK.LoggedData
                    section.data(9).logicalSrcIdx = 14;
                    section.data(9).dtTransOffset = 11;

            nTotData = nTotData + section.nData;
            dworkMap.sections(3) = section;
            clear section

            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% QUARC_simlink_DW.HILInitialize_QuadratureModes
                    section.data(1).logicalSrcIdx = 15;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_DW.HILInitialize_InitialEICounts
                    section.data(2).logicalSrcIdx = 16;
                    section.data(2).dtTransOffset = 2;

                    ;% QUARC_simlink_DW.HILReadEncoder_Buffer
                    section.data(3).logicalSrcIdx = 17;
                    section.data(3).dtTransOffset = 4;

                    ;% QUARC_simlink_DW.sfEvent
                    section.data(4).logicalSrcIdx = 18;
                    section.data(4).dtTransOffset = 6;

                    ;% QUARC_simlink_DW.sfEvent_c
                    section.data(5).logicalSrcIdx = 19;
                    section.data(5).dtTransOffset = 7;

                    ;% QUARC_simlink_DW.sfEvent_h
                    section.data(6).logicalSrcIdx = 20;
                    section.data(6).dtTransOffset = 8;

            nTotData = nTotData + section.nData;
            dworkMap.sections(4) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% QUARC_simlink_DW.is_active_c3_QUARC_simlink
                    section.data(1).logicalSrcIdx = 21;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_DW.is_active_c1_QUARC_simlink
                    section.data(2).logicalSrcIdx = 22;
                    section.data(2).dtTransOffset = 1;

                    ;% QUARC_simlink_DW.is_active_c2_QUARC_simlink
                    section.data(3).logicalSrcIdx = 23;
                    section.data(3).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            dworkMap.sections(5) = section;
            clear section

            section.nData     = 7;
            section.data(7)  = dumData; %prealloc

                    ;% QUARC_simlink_DW.doneDoubleBufferReInit
                    section.data(1).logicalSrcIdx = 24;
                    section.data(1).dtTransOffset = 0;

                    ;% QUARC_simlink_DW.previous_arm1_inpt_not_empty
                    section.data(2).logicalSrcIdx = 25;
                    section.data(2).dtTransOffset = 1;

                    ;% QUARC_simlink_DW.previous_arm2_inpt_not_empty
                    section.data(3).logicalSrcIdx = 26;
                    section.data(3).dtTransOffset = 2;

                    ;% QUARC_simlink_DW.i1_not_empty
                    section.data(4).logicalSrcIdx = 27;
                    section.data(4).dtTransOffset = 3;

                    ;% QUARC_simlink_DW.i2_not_empty
                    section.data(5).logicalSrcIdx = 28;
                    section.data(5).dtTransOffset = 4;

                    ;% QUARC_simlink_DW.doneDoubleBufferReInit_i
                    section.data(6).logicalSrcIdx = 29;
                    section.data(6).dtTransOffset = 5;

                    ;% QUARC_simlink_DW.doneDoubleBufferReInit_c
                    section.data(7).logicalSrcIdx = 30;
                    section.data(7).dtTransOffset = 6;

            nTotData = nTotData + section.nData;
            dworkMap.sections(6) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 3066231934;
    targMap.checksum1 = 3483435170;
    targMap.checksum2 = 1576280819;
    targMap.checksum3 = 2503208956;

