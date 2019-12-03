-- Levels of access
users = {
  None = {id = 255, hash = ''},
  Admin = {id = 1, hash = 'd17f25ecfbcc7857f7bebea469308be0b2580943e96d13a3ad98a13675c4bfc2'}, -- pass '11111'
  System = {id = 2, hash = 'cc399d73903f06ee694032ab0538f05634ff7e1ce5e8e50ac330a871484f34cf'}, -- pass '22222'
  Prot = {id = 4, hash = '216e683ff0d2d25165b8bb7ba608c9a628ef299924ca49ab981ec7d2fecd6dad'}, -- pass '33333'
  Comms = {id = 8, hash = 'e11d8cb94b54e0a2fd0e780f93dd51837fd39bf0c9b86f21e760d02a8550ddf7'}, -- pass '44444'
  Aux5 = {id = 16, hash = 'c507a68f3093e885765257ed3f176c757aaf62bb4cbc2ef94b2e7da3406d9676'}, -- pass '55555'
  Aux6 = {id = 32, hash = '1a7648bc484b3d9ed9e2226d223a6193d64e5e1fcacd97868adec665fe12b924'}, -- pass '66666'
  Aux7 = {id = 64, hash = '816e2845d395e7703abac2dcbf9d54e39236fd39133362bf7ad3fce70dd7d78e'}, -- pass '77777'
  Super = {id = 128, hash = '3d0a234093378eaffc3fe01cd6edbc3cd4302a37457b0c3bb3dd464a52c5a070'}, -- pass '88888'
  }

-- Type of RC
rc_type = {
  'Radial', 'Ring'
  }

-- Type of Control Module
cm_type = {
  'CM_15_4',  'CM_15_5',  'CM_15_6',
  }

-- Type of Switching Module
sm_type = {
  'ISM15_LD_1', 'ISM25_LD_1', 'ISM15_LD_8',
  'OSM15_Al_1', 'OSM25_Al_1', 'OSM15_Smart1',
  'ISM15_LD_8_S', 'ISM15_LD_1','OSM35_Smart_1'
  }

-- Functionality
functionality = {
  'RRE_4',  'RRE_5',  'RRE_6',
  'RLE_4',  'RLE_5',  'RLE_6',
  }

-- Phases
phases = {
  'X1/X2/X3', 'X4/X5/X6'
  }

--EUnits
units = {
  'kV', 'A', 'm'
}

-- Ranges
ranges = {
  {min = 1, max = 200},
  {min = 10.0, max = 6000.0},
}

tables = {
  -- Data indicated via MMI tables
  [1] =  {name = 'Identification'},
  [2] =  {name = 'PSE indication data', desc = 'Power supply element', permmission=255},
  -- ME indication data tables
  [3] =  {name = 'Overview', desription = nil, permission=255},
  [4] =  {name = 'Phase currents', desription = nil, permission=255},
  [5] =  {name = 'Current sequences', desription = nil, permission=255},
  [6] =  {name = 'Phase to earth voltages (+)', desription = nil, permission=255},
  [7] =  {name = 'Voltage sequences (+)', desription = nil, permission=255},
  [8] =  {name = 'Phase to phase voltages (+)', desription = nil, permission=255},
  [9] =  {name = 'Frequency (+)', desription = nil, permission=255},
  [10] = {name = 'Phase to earth voltages (-)', desription = nil, permission=255},
  [11] = {name = 'Voltage sequences (-)', desription = nil, permission=255},
  [12] = {name = 'Phase to phase voltages (-)', desription = nil, permission=255},
  [13] = {name = 'Frequency (-)', desription = nil, permission=255},
  [14] = {name = 'Active powers', desription = nil, permission=255},
  [15] = {name = 'Reactive powers', desription = nil, permission=255},
  [16] = {name = 'Power factors', desription = nil, permission=255},
  [17] = {name = 'Active energies', desription = nil, permission=255},
  [18] = {name = 'Reactive energies', desription = nil, permission=255},
  [19] = {name = 'Active energy, kWh (+)', desription = nil, permission=255},
  [20] = {name = 'Reactive energy, kVArh (+)', desription = nil, permission=255},
  [21] = {name = 'Apparent energy, kVAh (+)', desription = nil, permission=255},
  [22] = {name = 'Active energy, kWh (-)', desription = nil, permission=255},
  [23] = {name = 'Reactive energy, kVArh (-)', desription = nil, permission=255},
  [24] = {name = 'Apparent energy, kVAh (-)', desription = nil, permission=255},
  [25] = {name = ''},
}

settings = {
  [1] =  {name = 'Integer param', type = 'i', desription = nil, permission=2, units = units[1], value = 100, range = ranges[1]},
  [2] =  {name = 'Float param',   type = 'f', desription = nil, permission=1, units = units[2], value = 2.3, range = ranges[2]},
  [3] =  {name = 'Enum param',    type = 'e', desription = nil, permission=2, units = nil, value = 2, range = functionality},
  [4] =  {name = '', desription = nil, permission=255},
  [5] =  {name = '', desription = nil, permission=255},
  [6] =  {name = '', desription = nil, permission=255},
  [7] =  {name = '', desription = nil, permission=255},
  [8] =  {name = '', desription = nil, permission=255},
  [9] =  {name = '', desription = nil, permission=255},
  [10] = {name = '', desription = nil, permission=255},
}

datapoints = {
  {name = 'CM Type', type = 'e', description = 'Control module', permission = 2, unit = nil, value = 1, range = cm_type},
  {name = 'SM Type', type = 'e', description = 'Switching module', permission = 2, unit = nil, value = 1, range = sm_type},
  {name = 'Source side', type = 'e', description = nil, permission = 2, unit = nil, value = 1, range = phases},
  {name = 'Source for power', type = 'e', description = nil, permission = 2, unit = nil, value = 1, range = phases},
  {name = 'Lumb', type = 'f', description = 'Umbilical length', permission = 2, unit = 3, value = 50.0, range = ranges[2]},
}

setpoints = {
  {}
}

commands = {
  [1] =  {name = 'Protection', desription = nil, permission=255},
  [2] =  {name = 'Communication', desription = nil, permission=255},
  [3] =  {name = 'Energy meter', desription = nil, permission=255},
  [4] =  {name = '', desription = nil, permission=255},
  [5] =  {name = '', desription = nil, permission=255},
  [6] =  {name = '', desription = nil, permission=255},
  [7] =  {name = '', desription = nil, permission=255},
  [8] =  {name = '', desription = nil, permission=255},
  [9] =  {name = '', desription = nil, permission=255},
  [10] = {name = '', desription = nil, permission=255},
}

mixed = {
  [1] =  {name = 'System', desription = nil, permission=255},
  [2] =  {name = '', desription = nil, permission=255},
  [3] =  {name = '', desription = nil, permission=255},
  [4] =  {name = '', desription = nil, permission=255},
  [5] =  {name = '', desription = nil, permission=255},
  [6] =  {name = '', desription = nil, permission=255},
  [7] =  {name = '', desription = nil, permission=255},
  [8] =  {name = '', desription = nil, permission=255},
  [9] =  {name = '', desription = nil, permission=255},
  [10] = {name = '', desription = nil, permission=255},
}

menus = {
  [1] =  {name = 'Main menu',              rows = 3,  permission = 255, desc = nil, templ = 'Menu'},
  [2] =  {name = 'Data indicated via MMI', rows = 6,  permission = 255, desc = 'Man-machine interface', templ = 'Table'},
  [3] =  {name = 'MMI control data',       rows = 4,  permission = 255, desc = 'Man-machine interface', templ = 'Table'},
  [4] =  {name = 'Settings',               rows = 4,  permission = 255, desc = nil, templ = 'Menu'},
  [5] =  {name = 'ME indication data',     rows = 22, permission = 255, desc = 'Measurement element', templ = 'Menu'},
  [6] =  {name = 'IDC',                    rows = 6,  permission = 255, desc = 'Indication data conditioner', templ = 'Menu'},
  [7] =  {name = 'TCI indication data',    rows = 3,  permission = 255, desc = 'Telecommunication interface', templ = 'Menu'},
  [8] =  {name = 'EM verification data',   rows = 4,  permission = 255, desc = 'Energy Meter', templ = 'Menu'},
  [9] =  {name = 'System',                 rows = 9,  permission = 2, desc = nil, templ = 'Menu'},
  [10] = {name = 'Protection',             rows = 4,  permission = 255, desc = nil, templ = 'Menu'},
  [11] = {name = 'Communication',          rows = 4,  permission = 255, desc = nil, templ = 'Menu'},
  [12] = {name = 'Energy meter',           rows = 3,  permission = 255, desc = nil, templ = 'Menu'},
  [13] = {name = 'Configuration',           rows = 3,  permission = 2, desc = nil, templ = 'Settings'},
  [14] = {name = 'PCI settings',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
  [15] = {name = 'Item15',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
  [16] = {name = 'Item16',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
  [17] = {name = 'Item17',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
  [18] = {name = 'Item18',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
  [19] = {name = 'Item19',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
  [20] = {name = 'Item20',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
  [21] = {name = 'Item21',           rows = 3,  permission = 2, desc = nil, templ = 'Menu'},
}

menu_items = {
    -- Main menu
    [1] =  {name = menus[2].name,      ref = menus[2],    ref_type='sub',   permission = menus[2].permission,  owner = menus[1]},
    [2] =  {name = menus[3].name,      ref = menus[3],    ref_type='sub',   permission = menus[3].permission,  owner = menus[1]},
    [3] =  {name = menus[4].name,      ref = menus[4],    ref_type='sub',   permission = menus[4].permission,  owner = menus[1]},
    -- Data indicated via MMI
    [4] =  {name = tables[1].name,     ref = tables[1],   ref_type='table',   permission = tables[1].permission,      owner = menus[2]},
    [5] =  {name = menus[5].name,      ref = menus[5],    ref_type='sub',   permission = menus[5].permission,  owner = menus[2]},
    [6] =  {name = tables[2].name,     ref = tables[2],   ref_type='table',   permission = tables[2].permission,      owner = menus[2]},
    [7] =  {name = menus[6].name,      ref = menus[6],    ref_type='sub',   permission = menus[6].permission,  owner = menus[2]},
    [8] =  {name = menus[7].name,      ref = menus[7],    ref_type='sub',   permission = menus[7].permission,  owner = menus[2]},
    [9] =  {name = menus[8].name,      ref = menus[8],    ref_type='sub',   permission = menus[8].permission,  owner = menus[2]},
    -- MMI control data
    [10] = {name = mixed[1].name,      ref = mixed[1],    ref_type='set',   permission = mixed[1].permission,      owner = menus[3]},
    [11] = {name = commands[1].name,   ref = commands[1], ref_type='cmd', permission = commands[1].permission,      owner = menus[3]},
    [12] = {name = commands[2].name,   ref = commands[2], ref_type='cmd', permission = commands[2].permission,      owner = menus[3]},
    [13] = {name = commands[3].name,   ref = commands[3], ref_type='cmd', permission = commands[3].permission,      owner = menus[3]},
    -- Settings
    [14] = {name = menus[9].name,      ref = menus[9],    ref_type='sub',   permission = menus[9].permission,  owner = menus[4]},
    [15] = {name = menus[10].name,     ref = menus[10],   ref_type='sub',   permission = menus[10].permission, owner = menus[4]},
    [16] = {name = menus[11].name,     ref = menus[11],   ref_type='sub',   permission = menus[11].permission, owner = menus[4]},
    [17] = {name = menus[12].name,     ref = menus[12],   ref_type='sub',   permission = menus[12].permission, owner = menus[4]},
    -- ME indication  data
    [18] = {name = tables[3].name,     ref = tables[3],   ref_type='table',   permission = tables[3].permission,      owner = menus[5]},
    [19] = {name = tables[4].name,     ref = tables[4],   ref_type='table',   permission = tables[4].permission,      owner = menus[5]},
    [20] = {name = tables[5].name,     ref = tables[5],   ref_type='table',  permission = tables[5].permission,      owner = menus[5]},
    [21] = {name = tables[6].name,     ref = tables[6],   ref_type='table',   permission = tables[6].permission,      owner = menus[5]},
    [22] = {name = tables[7].name,     ref = tables[7],   ref_type='table',   permission = tables[7].permission,      owner = menus[5]},
    [23] = {name = tables[8].name,     ref = tables[8],   ref_type='table',   permission = tables[8].permission,      owner = menus[5]},
    [24] = {name = tables[9].name,     ref = tables[9],   ref_type='table',   permission = tables[9].permission,      owner = menus[5]},
    [25] = {name = tables[10].name,    ref = tables[10],  ref_type='table',   permission = tables[10].permission,      owner = menus[5]},
    [26] = {name = tables[11].name,    ref = tables[11],  ref_type='table',   permission = tables[11].permission,      owner = menus[5]},
    [27] = {name = tables[12].name,    ref = tables[12],  ref_type='table',   permission = tables[12].permission,      owner = menus[5]},
    [28] = {name = tables[13].name,    ref = tables[13],  ref_type='table',   permission = tables[13].permission,      owner = menus[5]},
    [29] = {name = tables[14].name,    ref = tables[14],  ref_type='table',   permission = tables[14].permission,      owner = menus[5]},
    [30] = {name = tables[15].name,    ref = tables[15],  ref_type='table',   permission = tables[15].permission,      owner = menus[5]},
    [31] = {name = tables[16].name,    ref = tables[16],  ref_type='table',   permission = tables[16].permission,      owner = menus[5]},
    [32] = {name = tables[17].name,    ref = tables[17],  ref_type='table',   permission = tables[17].permission,      owner = menus[5]},
    [33] = {name = tables[18].name,    ref = tables[18],  ref_type='table',   permission = tables[18].permission,      owner = menus[5]},
    [34] = {name = tables[19].name,    ref = tables[19],  ref_type='table',   permission = tables[19].permission,      owner = menus[5]},
    [35] = {name = tables[20].name,    ref = tables[20],  ref_type='table',   permission = tables[20].permission,      owner = menus[5]},
    [36] = {name = tables[21].name,    ref = tables[21],  ref_type='table',   permission = tables[21].permission,      owner = menus[5]},
    [37] = {name = tables[22].name,    ref = tables[22],  ref_type='table',   permission = tables[22].permission,      owner = menus[5]},
    [38] = {name = tables[23].name,    ref = tables[23],  ref_type='table',   permission = tables[23].permission,      owner = menus[5]},
    [39] = {name = tables[24].name,    ref = tables[24],  ref_type='table',   permission = tables[24].permission,      owner = menus[5]},
    -- System
    [40] = {name = menus[13].name,    ref = menus[13],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [41] = {name = menus[14].name,    ref = menus[14],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [42] = {name = menus[15].name,    ref = menus[15],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [43] = {name = menus[16].name,    ref = menus[16],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [44] = {name = menus[17].name,    ref = menus[17],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [45] = {name = menus[18].name,    ref = menus[18],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [46] = {name = menus[19].name,    ref = menus[19],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [47] = {name = menus[20].name,    ref = menus[20],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    [48] = {name = menus[21].name,    ref = menus[21],  ref_type='sub',   permission = menus[9].permission,      owner = menus[9]},
    --Configuration
    [49] = {name = settings[1].name,    ref = settings[1],  ref_type='set',   permission = menus[13].permission,      owner = menus[13]},
    [50] = {name = settings[2].name,    ref = settings[2],  ref_type='set',   permission = menus[13].permission,      owner = menus[13]},
    [51] = {name = settings[3].name,    ref = settings[3],  ref_type='set',   permission = menus[13].permission,      owner = menus[13]},
}
