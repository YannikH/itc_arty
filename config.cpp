class CfgPatches {
    class itc_air {
        name = "";
        units[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"CBA_Extended_EventHandlers"};
    };
};


class CfgFunctions
{
    class itc_arty
    {
        class general {
            class init {
                preInit = 1;
                file = "itc_arty\functions\init.sqf";
            };
            class vehicle_changed_handler {
                file = "itc_arty\functions\vehicleChangedHandler.sqf";
            };
        }
    };
};

//#include "cfgWeapons.hpp"
//#include "cfgVehicles.hpp"

class cfgVehicles {
    class B_MBT_01_arty_base_F;
    class B_MBT_01_arty_F : B_MBT_01_arty_base_F {
        artilleryScanner = 0;
        class itc_arty {
            type = "digital";
        };
    };

    class B_MBT_01_mlrs_base_F;
    class B_MBT_01_mlrs_F : B_MBT_01_mlrs_base_F {
        artilleryScanner = 0;
        class itc_arty {
            type = "digital";
        };
    };
};

class CfgAmmo {
    class ShellBase;
    class Sh_155mm_AMOS : ShellBase {
        artilleryLock = 0;
    };
}