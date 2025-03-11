mslsettings = {

    cbrn_SACLOS_msl = {
        MAX_STEERING_FORCE = 0.02,       -- Steer the missile towards the direction the cursor is pointing at, smaller num means the msl will try harder to maneuver when going closer to LOS
        MAX_CORRECTION_FORCE = 0.7,      -- Correct the missile flying path towards the LOS , larger num means the msl will try harder to go back to LOS
        MAX_ACCELERATION = 0.15,         -- Accelerate the missile in its current direction
        AVR_G_FORCE_MULTIPLIER = 3.0,    -- Decide how hard can the missile turn to LOS, larger means less maneuver ability
        TOLERANCE = 0.05,                -- Decide how much error from LOS, 0(0%) means it will not follow LOS, 1(100%) means it will try its best to follow LOS
        STEERAGE_MULTIPLIER = 0.80,      -- Decide how hard the missile can maneuver when in large , smaller num means less maneuver ability
        INIT_LAUNCH_SPEED = 8,           -- Initial launch speed
        DISABLE_RESISTANCE = false,      -- Will the missile take water resistance, Change this may lead to significant differences
        IS_AUTO_GUIDED = false,          -- Is the missile auto guided
        GUIDENCE_DELAY = 1.0,            -- Determine when will the missile start to guide to target
        LOCK_RANGE = 0,                  -- Only matters when missile is auto guided.
        CAN_LOST_LOS = true,             -- Decide if the missile will lost LOS when doing large maneuver
        FOV = 0.6                        -- Max Angel error between missile and target
    },

    std_8_utam = {
        MAX_STEERING_FORCE = 0.016,
        MAX_CORRECTION_FORCE = 0.85,
        MAX_ACCELERATION = 0.28,
        AVR_G_FORCE_MULTIPLIER = 2.0,
        TOLERANCE = 0.02,
        STEERAGE_MULTIPLIER = 0.90,
        INIT_LAUNCH_SPEED = 15,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = false,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },

    std_8_c_utam = {
        MAX_STEERING_FORCE = 0.016,
        MAX_CORRECTION_FORCE = 0.85,
        MAX_ACCELERATION = 0.28,
        AVR_G_FORCE_MULTIPLIER = 2.0,
        TOLERANCE = 0.02,
        STEERAGE_MULTIPLIER = 0.90,
        INIT_LAUNCH_SPEED = 15,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = true,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },

    std_8_mrd_utam = {
        MAX_STEERING_FORCE = 0.016,
        MAX_CORRECTION_FORCE = 0.85,
        MAX_ACCELERATION = 0.28,
        AVR_G_FORCE_MULTIPLIER = 2.0,
        TOLERANCE = 0.02,
        STEERAGE_MULTIPLIER = 0.90,
        INIT_LAUNCH_SPEED = 15,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = false,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },

    railgunjumppod_msl = {
        MAX_STEERING_FORCE = 0.016,
        MAX_CORRECTION_FORCE = 0.85,
        MAX_ACCELERATION = 0.28,
        AVR_G_FORCE_MULTIPLIER = 2.0,
        TOLERANCE = 0.02,
        STEERAGE_MULTIPLIER = 0.90,
        INIT_LAUNCH_SPEED = 15,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = false,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },

    railgunjumppod_msl_auto = {
        MAX_STEERING_FORCE = 0.016,
        MAX_CORRECTION_FORCE = 0.85,
        MAX_ACCELERATION = 0.28,
        AVR_G_FORCE_MULTIPLIER = 2.0,
        TOLERANCE = 0.02,
        STEERAGE_MULTIPLIER = 0.90,
        INIT_LAUNCH_SPEED = 15,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = true,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },

    ugm_114k_haven_water = {
        MAX_STEERING_FORCE = 0.015,
        MAX_CORRECTION_FORCE = 0.8,
        MAX_ACCELERATION = 0.5,
        AVR_G_FORCE_MULTIPLIER = 3.0,
        TOLERANCE = 0.01,
        STEERAGE_MULTIPLIER = 0.80,
        INIT_LAUNCH_SPEED = 10,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = false,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },

    ugm_114l_haven_water = {
        MAX_STEERING_FORCE = 0.015,
        MAX_CORRECTION_FORCE = 0.8,
        MAX_ACCELERATION = 0.5,
        AVR_G_FORCE_MULTIPLIER = 3.0,
        TOLERANCE = 0.01,
        STEERAGE_MULTIPLIER = 0.80,
        INIT_LAUNCH_SPEED = 10,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = true,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },

    sm_9_prsm = {
        MAX_STEERING_FORCE = 0.02,
        MAX_CORRECTION_FORCE = 0.6,
        MAX_ACCELERATION = 0.4,
        AVR_G_FORCE_MULTIPLIER = 1.5,
        TOLERANCE = 0.02,
        STEERAGE_MULTIPLIER = 1.0,
        INIT_LAUNCH_SPEED = 20,
        DISABLE_RESISTANCE = false,
        IS_AUTO_GUIDED = false,
        GUIDENCE_DELAY = 0.7,
        LOCK_RANGE = 0,
        CAN_LOST_LOS = false,
        FOV = 0.6
    },
}