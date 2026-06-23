local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Konfigurasi Statis (Kecepatan dikunci ke 80)
local walkSpeedValue = 60
local isAutoRunning = false

-- ==========================================
-- 1. KONFIGURASI KOORDINAT
-- ==========================================
local waypoints = {
    {pos = Vector3.new(-45.3, -456.0, -2049.0), action = "Jump"},
    {pos = Vector3.new(-83.5, -456.0, -2047.4), action = "Jump"},
    {pos = Vector3.new(-141.0, -456.0, -2049.0), action = "Jump"},
    {pos = Vector3.new(-184.2, -456.0, -2048.3), action = "Run"},
    {pos = Vector3.new(-329.7, -456.0, -2047.8), action = "Jump"},
    {pos = Vector3.new(-368.9, -456.0, -2048.3), action = "Jump"},
    {pos = Vector3.new(-426.6, -456.0, -2051.5), action = "Jump"},
    {pos = Vector3.new(-486.5, -456.0, -2051.2), action = "Jump"},
    {pos = Vector3.new(-540.2, -456.0, -2050.2), action = "Jump"},
    {pos = Vector3.new(-596.9, -456.0, -2048.4), action = "Jump"},
    {pos = Vector3.new(-641.3, -456.0, -2049.2), action = "Run"},
    {pos = Vector3.new(-815.3, -450.1, -2047.9 ), action = "Jump"},
    {pos = Vector3.new(-852.5, -456.7, -2047.1), action = "Jump"},
    {pos = Vector3.new(-902.8, -459.5, -2034.4), action = "Jump"},
    {pos = Vector3.new(-956.8, -456.9, -2047.0), action = "Jump"},
    {pos = Vector3.new(-1014.5, -460.6, -2059.1), action = "Jump"},
    {pos = Vector3.new(-1070.9, -456.7, -2052.4), action = "Jump"},
    {pos = Vector3.new(-1122.4, -456.0, -2071.7), action = "Jump"},
    {pos = Vector3.new(-1148.5, -450.0, -2097.4), action = "Jump"},
    {pos = Vector3.new(-1164.3, -444.0, -2116.8), action = "Jump"},
    {pos = Vector3.new(-1181.4, -438.0, -2127.4), action = "Jump"},
    {pos = Vector3.new(-1200.6, -432.0, -2134.8), action = "Jump"},
    {pos = Vector3.new(-1219.5, -426.0, -2131.4), action = "Jump"},
    {pos = Vector3.new(-1234.3, -420.0, -2122.9), action = "Jump"},
    {pos = Vector3.new(-1234.8, -414.0, -2097.6), action = "Run"},
    {pos = Vector3.new(-1214.9, -410.0, -2011.2), action = "Run"},
    {pos = Vector3.new(-1258.7, -415.5, -1951.7), action = "Jump"},
    {pos = Vector3.new(-1278.0, -418.3, -1924.5), action = "Jump"},
    {pos = Vector3.new(-1309.5, -418.3, -1884.1), action = "Jump"},
    {pos = Vector3.new(-1347.5, -414.1, -1848.7), action = "Jump"},
    {pos = Vector3.new(-1393.1, -418.3, -1830.1), action = "Jump"},
    {pos = Vector3.new(-1445.4, -418.3, -1813.1), action = "Jump"},
    {pos = Vector3.new(-1494.9, -414.0, -1790.5), action = "Run"},
    {pos = Vector3.new(-1509.7, -416.6, -1755.4), action = "Jump"},
    {pos = Vector3.new(-1522.5, -415.1, -1722.4), action = "Jump"},
    {pos = Vector3.new(-1539.8, -412.8, -1672.4), action = "Jump"},
    {pos = Vector3.new(-1563.9, -406.5, -1650.8), action = "Jump"},
    {pos = Vector3.new(-1602.5, -409.0, -1647.8), action = "Jump"},
    {pos = Vector3.new(-1655.8, -407.9, -1647.5), action = "Jump"},
    {pos = Vector3.new(-1709.7, -406.9, -1647.2), action = "Jump"},
    {pos = Vector3.new(-1753.3, -406.6, -1648.6), action = "Run"},
    {pos = Vector3.new(-1827.5, -406.1, -1619.1), action = "Run"},
    {pos = Vector3.new(-1908.6, -386.0, -1562.1), action = "Run"},
    {pos = Vector3.new(-1928.2, -391.8, -1494.9), action = "Jump"},
    {pos = Vector3.new(-1934.8, -389.9, -1469.5), action = "Run"},
    {pos = Vector3.new(-1954.1, -382.0, -1413.0), action = "Jump"},
    {pos = Vector3.new(-1978.3, -375.9, -1433.5), action = "Run"},
    {pos = Vector3.new(-1992.6, -369.3, -1448.4), action = "Jump"},
    {pos = Vector3.new(-2001.7, -365.2, -1457.1), action = "Run"},
    {pos = Vector3.new(-2028.7, -354.0, -1485.3), action = "Run"},
    {pos = Vector3.new(-2079.1, -349.5, -1492.7), action = "Jump"},
    {pos = Vector3.new(-2097.7, -343.8, -1495.7), action = "Run"},
    {pos = Vector3.new(-2138.4, -331.9, -1498.7), action = "Run"},
    {pos = Vector3.new(-2169.1, -320.0, -1418.6), action = "Run"},
    {pos = Vector3.new(-2222.0, -320.3, -1339.9), action = "Run"},
    {pos = Vector3.new(-2305.9, -320.4, -1327.8), action = "Jump"},
    {pos = Vector3.new(-2330.4, -320.4, -1295.2), action = "Run"},
    {pos = Vector3.new(-2324.5, -316.9, -1212.6), action = "Jump"},
    {pos = Vector3.new(-2351.6, -306.3, -1204.1), action = "Run"},
    {pos = Vector3.new(-2421.3, -287.8, -1184.1), action = "Run"},
    {pos = Vector3.new(-2404.7, -274.2, -1132.8), action = "Jump"},
    {pos = Vector3.new(-2397.2, -269.1, -1100.8), action = "Run"},
    {pos = Vector3.new(-2422.2, -269.1, -1071.7), action = "Jump"},
    {pos = Vector3.new(-2439.7, -269.1, -1050.6), action = "Run"},
    {pos = Vector3.new(-2486.1, -269.1, -994.8), action = "Jump"},
    {pos = Vector3.new(-2520.0, -285.2, -949.9), action = "Run"},
    {pos = Vector3.new(-2624.1, -267.2, -815.1), action = "Run"},
    {pos = Vector3.new(-2719.6, -278.0, -693.6), action = "Run"},
    {pos = Vector3.new(-2720.6, -307.1, -591.1), action = "Jump"},
    {pos = Vector3.new(-2722.7, -299.5, -573.3), action = "Run"},
    {pos = Vector3.new(-2724.0, -270.0, -532.6), action = "Jump"},
    {pos = Vector3.new(-2804.5, -319.6, -567.0), action = "Jump"},
    {pos = Vector3.new(-2833.3, -311.0, -585.6), action = "Run"},
    {pos = Vector3.new(-2879.0, -274.0, -609.3), action = "Run"},
    {pos = Vector3.new(-2888.0, -296.6, -565.4), action = "Jump"},
    {pos = Vector3.new(-2900.8, -300.0, -534.3), action = "Jump"},
    {pos = Vector3.new(-2908.8, -290.6, -511.8), action = "Run"},
    {pos = Vector3.new(-3001.3, -266.9, -271.7), action = "Jump"},
    {pos = Vector3.new(-3030.8, -270.4, -256.3), action = "Run"},
    {pos = Vector3.new(-3058.9, -266.1, -239.5), action = "Run"},
    {pos = Vector3.new(-3115.3, -268.2, -216.7), action = "Run"},
    {pos = Vector3.new(-3129.5, -268.1, -208.8), action = "Run"},
    {pos = Vector3.new(-3179.3, -268.1, -53.9), action = "Jump"},
    {pos = Vector3.new(-3186.6, -268.1, -30.2), action = "Jump"},
    {pos = Vector3.new(-3171.3, -263.1, -5.6), action = "Run"},
    {pos = Vector3.new(-3076.1, -221.7, 75.8), action = "Run"},
    {pos = Vector3.new(-3063.5, -206.0, 151.3), action = "Run"},
    {pos = Vector3.new(-3095.7, -205.9, 175.2), action = "Jump"},
    {pos = Vector3.new(-3111.7, -202.3, 187.6), action = "Run"},
    {pos = Vector3.new(-3126.9, -198.7, 200.4), action = "Jump"},
    {pos = Vector3.new(-3142.4, -195.3, 212.0), action = "Run"},
    {pos = Vector3.new(-3176.0, -186.0, 241.4), action = "Run"},
    {pos = Vector3.new(-3226.2, -188.4, 236.2), action = "Jump"},
    {pos = Vector3.new(-3248.6, -188.3, 232.9), action = "Run"},
    {pos = Vector3.new(-3273.1, -188.2, 229.4), action = "Jump"},
    {pos = Vector3.new(-3298.2, -188.0, 226.3), action = "Run"},
    {pos = Vector3.new(-3319.7, -187.9, 222.3), action = "Jump"},
    {pos = Vector3.new(-3345.1, -187.8, 218.3), action = "Run"},
    {pos = Vector3.new(-3367.9, -187.7, 216.4), action = "Jump"},
    {pos = Vector3.new(-3390.7, -187.5, 213.2), action = "Run"},
    {pos = Vector3.new(-3429.5, -182.0, 204.1), action = "Run"},
    {pos = Vector3.new(-3427.5, -185.4, 162.6), action = "Jump"},
    {pos = Vector3.new(-3428.0, -185.7, 146.5), action = "Run"},
    {pos = Vector3.new(-3427.9, -186.4, 118.9), action = "Jump"},
    {pos = Vector3.new(-3438.3, -186.9, 101.9), action = "Run"},
    {pos = Vector3.new(-3437.9, -187.4, 83.4), action = "Jump"},
    {pos = Vector3.new(-3423.2, -187.8, 65.4), action = "Run"},
    {pos = Vector3.new(-3423.3, -188.4, 40.9), action = "Jump"},
    {pos = Vector3.new(-3436.0, -188.9, 21.6), action = "Run"},
    {pos = Vector3.new(-3433.7, -189.4, 3.2), action = "Jump"},
    {pos = Vector3.new(-3420.6, -189.8, -13.7), action = "Run"},
    {pos = Vector3.new(-3417.9, -188.9, -77.4), action = "Run"},
    {pos = Vector3.new(-3373.5, -177.7, -49.4), action = "Jump"},
    {pos = Vector3.new(-3355.7, -171.1, -43.1), action = "Jump"},
    {pos = Vector3.new(-3339.5, -159.7, -19.7), action = "Jump"},
    {pos = Vector3.new(-3313.5, -148.1, -9.9), action = "Jump"},
    {pos = Vector3.new(-3295.9, -136.6, 12.2), action = "Jump"},
    {pos = Vector3.new(-3270.8, -126.6, 21.9), action = "Jump"},
    {pos = Vector3.new(-3252.9, -114.8, 44.8), action = "Jump"},
    {pos = Vector3.new(-3234.7, -105.2, 58.9), action = "Run"},
    {pos = Vector3.new(-3212.1, -98.0, 73.1), action = "Run"},
    {pos = Vector3.new(-3184.9, -104.1, 76.9), action = "Jump"},
    {pos = Vector3.new(-3164.3, -111.9, 70.4), action = "Jump"},
    {pos = Vector3.new(-3136.9, -122.5, 83.7), action = "Jump"},
    {pos = Vector3.new(-3111.2, -132.3, 77.5), action = "Jump"},
    {pos = Vector3.new(-3084.6, -144.0, 91.7), action = "Run"},
    {pos = Vector3.new(-2968.3, -160.4, 140.4), action = "Run"},
    {pos = Vector3.new(-2910.9, -153.5, 187.1), action = "Jump"},
    {pos = Vector3.new(-2886.4, -153.5, 208.9), action = "Jump"},
    {pos = Vector3.new(-2848.4, -153.5, 209.8), action = "Jump"},
    {pos = Vector3.new(-2824.2, -153.7, 218.2), action = "Jump"},
    {pos = Vector3.new(-2798.0, -153.8, 226.8), action = "Jump"},
    {pos = Vector3.new(-2771.9, -154.0, 237.3), action = "Jump"},
    {pos = Vector3.new(-2749.6, -154.1, 243.0), action = "Jump"},
    {pos = Vector3.new(-2722.1, -154.2, 254.0), action = "Jump"},
    {pos = Vector3.new(-2698.2, -154.4, 261.7), action = "Jump"},
    {pos = Vector3.new(-2669.2, -154.5, 271.8), action = "Jump"},
    {pos = Vector3.new(-2634.1, -164.1, 273.2), action = "Jump"},
    {pos = Vector3.new(-2622.6, -161.5, 297.2), action = "Jump"},
    {pos = Vector3.new(-2614.3, -154.8, 321.7), action = "Jump"},
    {pos = Vector3.new(-2603.3, -148.1, 348.8), action = "Jump"},
    {pos = Vector3.new(-2596.2, -141.4, 368.2), action = "Jump"},
    {pos = Vector3.new(-2587.2, -134.5, 394.0), action = "Jump"},
    {pos = Vector3.new(-2579.3, -127.9, 417.3), action = "Jump"},
    {pos = Vector3.new(-2571.8, -121.2, 443.2), action = "Jump"},
    {pos = Vector3.new(-2565.9, -118.8, 465.4), action = "Run"},
    {pos = Vector3.new(-2509.4, -120.1, 552.1), action = "Run"},
    {pos = Vector3.new(-2373.6, -142.0, 572.6), action = "Run"},
    {pos = Vector3.new(-2383.9, -146.2, 604.5), action = "Jump"},
    {pos = Vector3.new(-2399.0, -150.5, 622.4), action = "Run"},
    {pos = Vector3.new(-2415.5, -156.4, 660.8), action = "Jump"},
    {pos = Vector3.new(-2412.7, -169.1, 687.6), action = "Run"},
    {pos = Vector3.new(-2428.0, -176.3, 728.9), action = "Jump"},
    {pos = Vector3.new(-2439.5, -173.9, 741.8), action = "Run"},
    {pos = Vector3.new(-2453.5, -170.0, 795.6), action = "Run"},
    {pos = Vector3.new(-2417.6, -173.9, 783.8), action = "Run"},
    {pos = Vector3.new(-2254.6, -204.8, 688.3), action = "Run"},
    {pos = Vector3.new(-2215.1, -202.0, 701.9), action = "Run"},
    {pos = Vector3.new(-2253.9, -215.8, 755.3), action = "Run"},
    {pos = Vector3.new(-2258.0, -223.7, 769.4), action = "Run"},
    {pos = Vector3.new(-2293.8, -248.6, 819.8), action = "Run"},
    {pos = Vector3.new(-2334.0, -254.0, 865.1), action = "Run"},
    {pos = Vector3.new(-2320.7, -256.5, 900.5), action = "Jump"},
    {pos = Vector3.new(-2299.5, -255.7, 923.7), action = "Run"},
    {pos = Vector3.new(-2254.1, -255.7, 934.7), action = "Run"},
    {pos = Vector3.new(-2267.6, -248.3, 924.4), action = "Run"},
    {pos = Vector3.new(-2250.5, -248.3, 906.2), action = "Run"},
    {pos = Vector3.new(-2238.4, -240.3, 920.9), action = "Run"},
    {pos = Vector3.new(-2221.1, -232.5, 934.9), action = "Run"},
    {pos = Vector3.new(-2238.3, -232.5, 950.0), action = "Run"},
    {pos = Vector3.new(-2253.9, -224.5, 937.0), action = "Run"},
    {pos = Vector3.new(-2267.0, -217.4, 921.3), action = "Run"},
    {pos = Vector3.new(-2205.9, -209.4, 880.3), action = "Run"},
    {pos = Vector3.new(-2158.5, -209.9, 924.1), action = "Run"},
    {pos = Vector3.new(-2049.1, -211.9, 1037.2), action = "Run"},
    {pos = Vector3.new(-2018.4, -207.1, 1053.9), action = "Run"},
    {pos = Vector3.new(-1974.8, -201.3, 1041.5), action = "Run"},
    {pos = Vector3.new(-1955.1, -197.0, 1012.8), action = "Run"},
    {pos = Vector3.new(-1958.3, -191.6, 970.7), action = "Run"},
    {pos = Vector3.new(-1986.0, -186.7, 943.5), action = "Run"},
    {pos = Vector3.new(-2023.1, -181.9, 940.7), action = "Run"},
    {pos = Vector3.new(-2056.2, -177.2, 958.7), action = "Run"},
    {pos = Vector3.new(-2069.3, -171.5, 1002.7), action = "Jump"},
    {pos = Vector3.new(-2059.1, -167.1, 1036.3), action = "Run"},
    {pos = Vector3.new(-2062.8, -163.8, 1061.8), action = "Run"},
    {pos = Vector3.new(-2082.6, -159.3, 1090.9), action = "Run"},
    {pos = Vector3.new(-2120.5, -154.4, 1096.6), action = "Run"},
    {pos = Vector3.new(-2157.7, -149.1, 1081.2), action = "Run"},
    {pos = Vector3.new(-2170.6, -144.4, 1046.0), action = "Run"},
    {pos = Vector3.new(-2158.9, -139.0, 1006.9), action = "Jump"},
    {pos = Vector3.new(-2133.0, -134.9, 988.1), action = "Run"},
    {pos = Vector3.new(-2089.0, -129.2, 992.0), action = "Run"},
    {pos = Vector3.new(-2071.8, -127.3, 1007.7), action = "Run"},
    {pos = Vector3.new(-1955.3, -121.2, 1122.5), action = "Run"},
    {pos = Vector3.new(-1902.4, -122.9, 1169.2), action = "Run"},
    {pos = Vector3.new(-1893.8, -126.8, 1175.3), action = "Run"},
    {pos = Vector3.new(-1927.5, -146.1, 1217.8), action = "Run"},
    {pos = Vector3.new(-1916.6, -146.1, 1225.0), action = "Jump"},
    {pos = Vector3.new(-1897.2, -146.1, 1242.2), action = "Run"},
    {pos = Vector3.new(-1883.3, -146.1, 1251.5), action = "Run"},
    {pos = Vector3.new(-1863.8, -136.5, 1226.7), action = "Jump"},
    {pos = Vector3.new(-1853.1, -128.5, 1211.6), action = "Run"},
    {pos = Vector3.new(-1831.5, -113.8, 1185.4), action = "Jump"},
    {pos = Vector3.new(-1819.2, -104.3, 1167.1), action = "Run"},
    {pos = Vector3.new(-1793.0, -93.0, 1138.2), action = "Run"},
    {pos = Vector3.new(-1748.6, -92.9, 1175.0), action = "Run"},
    {pos = Vector3.new(-1770.3, -103.9, 1203.6), action = "Jump"},
    {pos = Vector3.new(-1797.9, -124.3, 1242.0), action = "Run"},
    {pos = Vector3.new(-1819.7, -134.2, 1268.7), action = "Run"},
    {pos = Vector3.new(-1768.2, -90.5, 1302.2), action = "Run"},
    {pos = Vector3.new(-1797.3, -88.4, 1343.0), action = "Run"},
    {pos = Vector3.new(-1795.3, -88.1, 1359.3), action = "Jump"},
    {pos = Vector3.new(-1790.8, -87.4, 1384.1), action = "Run"},
    {pos = Vector3.new(-1787.5, -86.8, 1406.7), action = "Jump"},
    {pos = Vector3.new(-1785.2, -86.1, 1429.4), action = "Run"},
    {pos = Vector3.new(-1784.0, -85.3, 1451.7), action = "Jump"},
    {pos = Vector3.new(-1777.6, -84.8, 1472.8), action = "Run"},
    {pos = Vector3.new(-1737.9, -86.0, 1466.6), action = "Run"},
    {pos = Vector3.new(-1751.2, -69.3, 1358.1), action = "Run"},
    {pos = Vector3.new(-1705.8, -70.7, 1351.2), action = "Run"},
    {pos = Vector3.new(-1695.2, -66.0, 1409.4), action = "Run"},
    {pos = Vector3.new(-1661.8, -66.5, 1439.7), action = "Jump"},
    {pos = Vector3.new(-1647.5, -74.0, 1451.0), action = "Jump"},
    {pos = Vector3.new(-1625.4, -82.8, 1467.8), action = "Jump"},
    {pos = Vector3.new(-1605.9, -88.7, 1486.1), action = "Jump"},
    {pos = Vector3.new(-1581.8, -92.6, 1503.7), action = "Jump"},
    {pos = Vector3.new(-1559.0, -93.7, 1519.7), action = "Jump"},
    {pos = Vector3.new(-1537.8, -92.4, 1537.6), action = "Jump"},
    {pos = Vector3.new(-1517.3, -89.0, 1553.2), action = "Jump"},
    {pos = Vector3.new(-1493.0, -82.5, 1569.5), action = "Jump"},
    {pos = Vector3.new(-1474.6, -73.8, 1586.3), action = "Jump"},
    {pos = Vector3.new(-1455.4, -62.9, 1602.9), action = "Jump"},
    {pos = Vector3.new(-1434.7, -52.1, 1617.9), action = "Jump"},
    {pos = Vector3.new(-1416.2, -42.3, 1632.4), action = "Jump"},
    {pos = Vector3.new(-1396.4, -32.0, 1647.0), action = "Jump"},
    {pos = Vector3.new(-1376.9, -21.9, 1661.4), action = "Jump"},
    {pos = Vector3.new(-1358.7, -11.9, 1676.8), action = "Jump"},
    {pos = Vector3.new(-1336.7, -0.6, 1692.4), action = "Jump"},
    {pos = Vector3.new(-1318.9, 8.8, 1705.9), action = "Jump"},
    {pos = Vector3.new(-1300.5, 18.8, 1721.1), action = "Jump"},
    {pos = Vector3.new(-1277.6, 30.0, 1739.4), action = "Jump"},
    {pos = Vector3.new(-1261.7, 29.6, 1751.5), action = "Jump"},
    {pos = Vector3.new(-1247.1, 23.1, 1762.2), action = "Jump"},
    {pos = Vector3.new(-1223.5, 24.0, 1779.1), action = "Jump"},
    {pos = Vector3.new(-1202.8, 27.4, 1797.7), action = "Jump"},
    {pos = Vector3.new(-1181.4, 32.9, 1813.5), action = "Jump"},
    {pos = Vector3.new(-1158.4, 41.6, 1830.4), action = "Jump"},
    {pos = Vector3.new(-1138.1, 52.0, 1845.9), action = "Jump"},
    {pos = Vector3.new(-1118.3, 64.0, 1861.8), action = "Jump"},
    {pos = Vector3.new(-1099.9, 75.5, 1877.3), action = "Run"},
    {pos = Vector3.new(-1029.0, 128.3, 1929.3), action = "Run"},
    {pos = Vector3.new(-1053.7, 91.2, 1962.6), action = "Jump"},
    {pos = Vector3.new(-1069.3, 87.4, 1989.0), action = "Jump"},
    {pos = Vector3.new(-1090.2, 95.3, 2014.9), action = "Jump"},
    {pos = Vector3.new(-1105.2, 103.2, 2040.3), action = "Jump"},
    {pos = Vector3.new(-1126.3, 111.1, 2064.2), action = "Jump"},
    {pos = Vector3.new(-1141.6, 120.5, 2084.0), action = "Jump"},
    {pos = Vector3.new(-1162.7, 120.2, 2100.2), action = "Jump"},
    {pos = Vector3.new(-1179.9, 120.3, 2123.9), action = "Jump"},
    {pos = Vector3.new(-1196.2, 120.4, 2144.7), action = "Jump"},
    {pos = Vector3.new(-1207.0, 120.4, 2157.6), action = "Jump"},
    {pos = Vector3.new(-1224.2, 112.0, 2160.4), action = "Jump"},
    {pos = Vector3.new(-1238.7, 112.3, 2164.1), action = "Jump"},
    {pos = Vector3.new(-1258.3, 116.5, 2180.4), action = "Jump"},
    {pos = Vector3.new(-1268.8, 116.6, 2191.1), action = "Jump"},
    {pos = Vector3.new(-1277.1, 120.5, 2214.5), action = "Jump"},
    {pos = Vector3.new(-1282.1, 120.4, 2229.3), action = "Jump"},
    {pos = Vector3.new(-1289.1, 124.2, 2251.6), action = "Jump"},
    {pos = Vector3.new(-1271.2, 127.3, 2295.7), action = "Jump"},
    {pos = Vector3.new(-1237.0, 130.2, 2319.7), action = "Jump"},
    {pos = Vector3.new(-1194.3, 133.2, 2327.2), action = "Jump"},
    {pos = Vector3.new(-1157.9, 136.6, 2313.7), action = "Jump"},
    {pos = Vector3.new(-1114.3, 139.8, 2303.4), action = "Jump"},
    {pos = Vector3.new(-1081.2, 142.6, 2341.7), action = "Jump"},
    {pos = Vector3.new(-1027.6, 140.0, 2334.6), action = "Jump"},
    {pos = Vector3.new(-1010.3, 136.9, 2314.1), action = "Run"},
    {pos = Vector3.new(-989.1, 136.6, 2309.9), action = "Jump"},
    {pos = Vector3.new(-962.4, 136.2, 2304.3), action = "Run"},
    {pos = Vector3.new(-939.7, 135.9, 2298.6), action = "Jump"},
    {pos = Vector3.new(-912.4, 133.0, 2309.0), action = "Run"},
    {pos = Vector3.new(-891.8, 147.5, 2306.5), action = "Run"},
    {pos = Vector3.new(-861.4, 149.1, 2299.7), action = "Run"},
    {pos = Vector3.new(-849.1, 148.4, 2315.7), action = "Run"},
    {pos = Vector3.new(-855.8, 143.9, 2340.5), action = "Jump"},
    {pos = Vector3.new(-871.5, 146.8, 2351.2), action = "Run"},
    {pos = Vector3.new(-881.1, 146.8, 2370.8), action = "Jump"},
    {pos = Vector3.new(-863.1, 152.2, 2376.5), action = "Run"},
    {pos = Vector3.new(-869.9, 152.2, 2394.4), action = "Jump"},
    {pos = Vector3.new(-857.6, 157.8, 2404.0), action = "Run"},
    {pos = Vector3.new(-865.3, 157.7, 2421.8), action = "Jump"},
    {pos = Vector3.new(-876.8, 152.6, 2445.7), action = "Run"},
    {pos = Vector3.new(-893.2, 155.3, 2474.6), action = "Run"},
    {pos = Vector3.new(-946.7, 151.8, 2495.8), action = "Jump"},
    {pos = Vector3.new(-982.8, 152.1, 2504.8), action = "Jump"},
    {pos = Vector3.new(-999.8, 153.6, 2512.9), action = "Jump"},
    {pos = Vector3.new(-1022.3, 152.6, 2515.6), action = "Jump"},
    {pos = Vector3.new(-1044.8, 159.0, 2529.6), action = "Run"},
    {pos = Vector3.new(-1115.8, 159.9, 2552.6), action = "Run"},
    {pos = Vector3.new(-1119.5, 157.6, 2539.0), action = "Run"},
    {pos = Vector3.new(-1133.6, 157.3, 2533.0), action = "Run"},
    {pos = Vector3.new(-1151.2, 156.9, 2530.0), action = "Run"},
    {pos = Vector3.new(-1164.9, 156.9, 2537.4), action = "Jump"},
    {pos = Vector3.new(-1184.1, 140.2, 2509.0), action = "Run"},
    {pos = Vector3.new(-1199.2, 156.1, 2470.5), action = "Run"},
    {pos = Vector3.new(-1245.4, 156.7, 2485.3), action = "Run"},
    {pos = Vector3.new(-1254.3, 157.0, 2463.1), action = "Run"},
    {pos = Vector3.new(-1268.5, 182.9, 2427.5), action = "Run"},
    {pos = Vector3.new(-1276.9, 183.3, 2398.4), action = "Jump"},
    {pos = Vector3.new(-1300.5, 156.0, 2374.8), action = "Run"},
    {pos = Vector3.new(-1330.6, 156.4, 2385.5), action = "Run"},
    {pos = Vector3.new(-1342.7, 152.6, 2354.6), action = "Run"},
    {pos = Vector3.new(-1369.0, 167.0, 2314.7), action = "Run"},
    {pos = Vector3.new(-1380.2, 165.9, 2288.6), action = "Jump"},
    {pos = Vector3.new(-1395.6, 153.1, 2255.4), action = "Jump"},
    {pos = Vector3.new(-1374.3, 155.7, 2239.7), action = "Jump"},
    {pos = Vector3.new(-1349.1, 143.4, 2211.0), action = "Jump"},
    {pos = Vector3.new(-1330.0, 155.9, 2184.8), action = "Jump"},
    {pos = Vector3.new(-1325.2, 144.8, 2142.5), action = "Jump"},
    {pos = Vector3.new(-1295.1, 155.7, 2143.7), action = "Jump"},
    {pos = Vector3.new(-1294.7, 152.8, 2101.5), action = "Jump"},
    {pos = Vector3.new(-1285.4, 164.6, 2066.8), action = "Jump"},
    {pos = Vector3.new(-1257.5, 174.7, 2077.1), action = "Run"},
    {pos = Vector3.new(-1238.5, 186.0, 2050.5), action = "Run"},
    {pos = Vector3.new(-1233.0, 185.7, 2064.7), action = "Run"},
    {pos = Vector3.new(-1217.4, 186.0, 2164.2), action = "Run"},
    {pos = Vector3.new(-1120.2, 210.0, 2266.4), action = "Run"},
    {pos = Vector3.new(-1105.7, 216.7, 2323.1), action = "Jump"},
    {pos = Vector3.new(-1102.4, 215.1, 2345.7), action = "Run"},
    {pos = Vector3.new(-1097.8, 215.5, 2366.7), action = "Jump"},
    {pos = Vector3.new(-1081.6, 210.2, 2394.7), action = "Run"},
    {pos = Vector3.new(-1071.4, 210.6, 2412.2), action = "Jump"},
    {pos = Vector3.new(-1040.6, 211.1, 2432.4), action = "Run"},
    {pos = Vector3.new(-1023.4, 211.3, 2438.7), action = "Jump"},
    {pos = Vector3.new(-991.5, 210.8, 2445.1), action = "Run"},
    {pos = Vector3.new(-971.5, 210.9, 2447.1), action = "Jump"},
    {pos = Vector3.new(-935.2, 210.9, 2442.3), action = "Run"},
    {pos = Vector3.new(-915.9, 210.9, 2438.0), action = "Jump"},
    {pos = Vector3.new(-888.8, 210.7, 2421.5), action = "Run"},
    {pos = Vector3.new(-876.1, 210.4, 2404.5), action = "Jump"},
    {pos = Vector3.new(-873.4, 209.8, 2376.7), action = "Run"},
    {pos = Vector3.new(-888.9, 209.5, 2359.6), action = "Jump"},
    {pos = Vector3.new(-909.9, 209.0, 2338.3), action = "Run"},
    {pos = Vector3.new(-916.6, 208.8, 2329.0), action = "Jump"},
    {pos = Vector3.new(-890.4, 208.5, 2307.6), action = "Run"},
    {pos = Vector3.new(-876.1, 208.2, 2293.4), action = "Jump"},
    {pos = Vector3.new(-855.3, 207.8, 2268.3), action = "Run"},
    {pos = Vector3.new(-838.6, 207.6, 2252.9), action = "Jump"},
    {pos = Vector3.new(-820.6, 207.2, 2229.3), action = "Run"},
    {pos = Vector3.new(-799.7, 207.0, 2218.4), action = "Jump"},
    {pos = Vector3.new(-778.6, 194.0, 2205.6), action = "Run"},
    {pos = Vector3.new(-726.2, 195.0, 2187.9), action = "Run"},
    {pos = Vector3.new(-686.9, 193.9, 2125.0), action = "Jump"},
    {pos = Vector3.new(-672.2, 198.4, 2108.7), action = "Run"},
    {pos = Vector3.new(-640.9, 208.0, 2109.5), action = "Jump"},
    {pos = Vector3.new(-632.9, 202.5, 2084.0), action = "Run"},
    {pos = Vector3.new(-674.1, 215.9, 2053.5), action = "Jump"},
    {pos = Vector3.new(-658.4, 216.4, 2028.1), action = "Run"},
    {pos = Vector3.new(-609.2, 226.9, 2003.5), action = "Jump"},
    {pos = Vector3.new(-637.9, 224.3, 1989.9), action = "Run"},
    {pos = Vector3.new(-687.5, 204.1, 1977.5), action = "Jump"},
    {pos = Vector3.new(-706.3, 204.1, 1952.6), action = "Jump"},
    {pos = Vector3.new(-673.2, 202.2, 1932.1), action = "Run"},
    {pos = Vector3.new(-650.0, 212.0, 1937.5), action = "Run"},
    {pos = Vector3.new(-643.0, 229.5, 1889.4), action = "Run"},
    {pos = Vector3.new(-741.6, 214.4, 1893.3), action = "Jump"},
    {pos = Vector3.new(-759.8, 216.9, 1865.3), action = "Jump"},
    {pos = Vector3.new(-770.2, 214.1, 1859.6), action = "Run"},
    {pos = Vector3.new(-773.2, 243.7, 1857.7), action = "Run"},
    {pos = Vector3.new(-828.9, 245.4, 1878.3), action = "Run"},
    {pos = Vector3.new(-878.6, 245.4, 1920.9), action = "Run"},
    {pos = Vector3.new(-969.7, 215.1, 1972.0), action = "Run"},
    {pos = Vector3.new(-915.8, 249.6, 2052.6), action = "Run"},
    {pos = Vector3.new(-978.4, 262.8, 2092.5), action = "Run"},
    {pos = Vector3.new(-993.3, 257.3, 2080.1), action = "Jump"},
    {pos = Vector3.new(-1011.1, 256.0, 2056.8), action = "Jump"},
    {pos = Vector3.new(-1038.1, 262.1, 2054.2), action = "Jump"},
    {pos = Vector3.new(-1066.4, 257.6, 2075.5), action = "Jump"},
    {pos = Vector3.new(-1090.8, 256.6, 2052.2), action = "Jump"},
    {pos = Vector3.new(-1120.2, 256.9, 2077.9), action = "Jump"},
    {pos = Vector3.new(-1121.2, 261.2, 2124.3), action = "Jump"},
    {pos = Vector3.new(-1107.0, 257.2, 2168.5), action = "Jump"},
    {pos = Vector3.new(-1078.2, 256.8, 2197.5), action = "Jump"},
    {pos = Vector3.new(-1069.0, 263.1, 2205.0), action = "Jump"},
    {pos = Vector3.new(-1042.1, 265.4, 2232.2), action = "Jump"},
    {pos = Vector3.new(-1011.4, 265.3, 2261.2), action = "Run"},
    {pos = Vector3.new(-1034.8, 290.6, 2318.1), action = "Run"},
    {pos = Vector3.new(-1065.5, 289.2, 2361.1), action = "Run"},
    {pos = Vector3.new(-1026.4, 288.5, 2378.7), action = "Jump"},
    {pos = Vector3.new(-1009.5, 286.9, 2383.3), action = "Jump"},
    {pos = Vector3.new(-990.7, 286.6, 2385.7), action = "Jump"},
    {pos = Vector3.new(-961.8, 295.7, 2386.3), action = "Run"},
    {pos = Vector3.new(-934.8, 298.0, 2385.1), action = "Run"},
    {pos = Vector3.new(-912.3, 297.8, 2363.7), action = "Jump"},
    {pos = Vector3.new(-909.4, 295.4, 2352.1), action = "Jump"},
    {pos = Vector3.new(-892.7, 292.8, 2335.6), action = "Jump"},
    {pos = Vector3.new(-876.2, 290.3, 2321.3), action = "Jump"},
    {pos = Vector3.new(-867.3, 290.3, 2309.4), action = "Run"},
    {pos = Vector3.new(-801.3, 290.3, 2253.4), action = "Run"},
    {pos = Vector3.new(-795.2, 336.5, 2246.0), action = "Run"},
    {pos = Vector3.new(-772.2, 338.0, 2232.2), action = "Run"},
    {pos = Vector3.new(-752.8, 337.3, 2250.9), action = "Jump"},
    {pos = Vector3.new(-728.9, 332.2, 2271.3), action = "Jump"},
    {pos = Vector3.new(-702.0, 332.2, 2299.9), action = "Jump"},
    {pos = Vector3.new(-670.5, 332.2, 2333.1), action = "Jump"},
    {pos = Vector3.new(-642.1, 326.4, 2359.1), action = "Jump"},
    {pos = Vector3.new(-616.0, 309.6, 2384.2), action = "Jump"},
    {pos = Vector3.new(-591.3, 296.9, 2400.1), action = "Jump"},
    {pos = Vector3.new(-554.9, 282.1, 2400.9), action = "Jump"},
    {pos = Vector3.new(-530.3, 271.9, 2394.8), action = "Jump"},
    {pos = Vector3.new(-501.3, 259.8, 2387.4), action = "Jump"},
    {pos = Vector3.new(-477.6, 246.3, 2368.1), action = "Jump"},
    {pos = Vector3.new(-460.5, 233.5, 2338.5), action = "Jump"},
    {pos = Vector3.new(-449.9, 231.5, 2310.9), action = "Run"},
    {pos = Vector3.new(-449.0, 237.3, 2262.8), action = "Jump"},
    {pos = Vector3.new(-465.3, 245.3, 2229.9), action = "Jump"},
    {pos = Vector3.new(-490.8, 260.0, 2203.4), action = "Jump"},
    {pos = Vector3.new(-515.9, 274.5, 2177.1), action = "Jump"},
    {pos = Vector3.new(-536.0, 286.0, 2154.1), action = "Run"},
    {pos = Vector3.new(-588.8, 286.0, 2103.1), action = "Run"},
    {pos = Vector3.new(-609.1, 288.8, 2083.5), action = "Run"},
    {pos = Vector3.new(-628.6, 301.3, 2066.6), action = "Run"},
    {pos = Vector3.new(-654.4, 303.8, 2056.4), action = "Run"},
    {pos = Vector3.new(-669.4, 306.4, 2031.5), action = "Run"},
    {pos = Vector3.new(-663.4, 307.0, 2000.4), action = "Run"},
    {pos = Vector3.new(-639.6, 307.5, 1986.2), action = "Run"},
    {pos = Vector3.new(-608.1, 301.6, 1983.2), action = "Run"},
    {pos = Vector3.new(-559.1, 302.0, 1978.4), action = "Run"},
    {pos = Vector3.new(-523.9, 302.0, 1963.9), action = "Run"},
    {pos = Vector3.new(-505.6, 302.2, 1943.0), action = "Jump"},
    {pos = Vector3.new(-501.4, 302.2, 1933.9), action = "Run"},
    {pos = Vector3.new(-498.4, 302.3, 1913.1), action = "Jump"},
    {pos = Vector3.new(-501.1, 306.2, 1902.0), action = "Run"},
    {pos = Vector3.new(-512.4, 316.5, 1892.1), action = "Run"},
    {pos = Vector3.new(-529.0, 319.6, 1868.5), action = "Jump"},
    {pos = Vector3.new(-550.3, 317.9, 1856.3), action = "Run"},
    {pos = Vector3.new(-572.3, 318.2, 1855.5), action = "Run"},
    {pos = Vector3.new(-601.7, 319.0, 1858.9), action = "Run"},
    {pos = Vector3.new(-674.6, 318.1, 1891.3), action = "Jump"},
    {pos = Vector3.new(-695.9, 318.1, 1903.5), action = "Jump"},
    {pos = Vector3.new(-712.2, 318.7, 1902.4), action = "Jump"},
    {pos = Vector3.new(-722.5, 319.1, 1892.8), action = "Jump"},
    {pos = Vector3.new(-728.6, 319.6, 1880.3), action = "Jump"},
    {pos = Vector3.new(-727.4, 320.1, 1865.6), action = "Jump"},
    {pos = Vector3.new(-718.5, 320.8, 1852.6), action = "Jump"},
    {pos = Vector3.new(-700.7, 320.7, 1835.5), action = "Jump"},
    {pos = Vector3.new(-696.5, 320.6, 1829.4), action = "Jump"},
    {pos = Vector3.new(-681.8, 320.4, 1810.4), action = "Jump"},
    {pos = Vector3.new(-675.8, 320.4, 1804.8), action = "Jump"},
    {pos = Vector3.new(-658.4, 320.3, 1787.9), action = "Jump"},
    {pos = Vector3.new(-648.9, 320.2, 1776.6), action = "Jump"},
    {pos = Vector3.new(-651.0, 320.0, 1756.9), action = "Jump"},
    {pos = Vector3.new(-650.8, 322.2, 1744.5), action = "Jump"},
    {pos = Vector3.new(-650.9, 324.5, 1727.0), action = "Jump"},
    {pos = Vector3.new(-666.9, 327.4, 1722.4), action = "Jump"},
    {pos = Vector3.new(-681.1, 328.7, 1725.1), action = "Jump"},
    {pos = Vector3.new(-696.4, 329.4, 1734.8), action = "Run"},
    {pos = Vector3.new(-750.7, 335.6, 1802.5), action = "Jump"},
    {pos = Vector3.new(-753.4, 344.1, 1828.8), action = "Jump"},
    {pos = Vector3.new(-746.4, 352.1, 1850.9), action = "Jump"},
    {pos = Vector3.new(-752.4, 358.0, 1872.0), action = "Jump"},
    {pos = Vector3.new(-762.2, 362.6, 1885.8), action = "Jump"},
    {pos = Vector3.new(-764.0, 367.3, 1900.7), action = "Run"},
    {pos = Vector3.new(-756.0, 381.2, 1964.9), action = "Run"},
    {pos = Vector3.new(-723.6, 383.9, 1998.0), action = "Run"},
    {pos = Vector3.new(-693.4, 382.0, 2042.4), action = "Run"},
    {pos = Vector3.new(-647.7, 385.8, 2085.5), action = "Run"},
    {pos = Vector3.new(-663.0, 386.2, 2104.2), action = "Run"},
    {pos = Vector3.new(-684.6, 399.1, 2126.9), action = "Run"},
    {pos = Vector3.new(-707.5, 399.3, 2151.8), action = "Jump"},
    {pos = Vector3.new(-722.7, 399.3, 2176.9), action = "Run"},
    {pos = Vector3.new(-734.7, 399.4, 2189.8), action = "Jump"},
    {pos = Vector3.new(-738.0, 399.3, 2203.1), action = "Run"},
    {pos = Vector3.new(-737.9, 399.1, 2217.9), action = "Jump"},
    {pos = Vector3.new(-751.4, 407.6, 2217.2), action = "Jump"},
    {pos = Vector3.new(-770.1, 415.9, 2223.4), action = "Jump"},
    {pos = Vector3.new(-765.7, 415.6, 2244.0), action = "Jump"},
    {pos = Vector3.new(-782.5, 423.9, 2240.6), action = "Jump"},
    {pos = Vector3.new(-777.1, 423.7, 2254.4), action = "Run"},
    {pos = Vector3.new(-778.2, 423.6, 2270.6), action = "Run"},
    {pos = Vector3.new(-832.9, 424.4, 2273.3), action = "Jump"},
    {pos = Vector3.new(-835.6, 430.4, 2296.4), action = "Jump"},
    {pos = Vector3.new(-839.8, 436.0, 2317.5), action = "Run"},
    {pos = Vector3.new(-920.3, 437.3, 2321.7), action = "Run"},
    {pos = Vector3.new(-922.5, 418.0, 2285.5), action = "Run"},
    {pos = Vector3.new(-971.5, 375.6, 2137.1), action = "Run"},
    {pos = Vector3.new(-914.5, 448.7, 2199.5), action = "Run"},
}

local function applyStats(humanoid)
    if humanoid then
        humanoid.WalkSpeed = walkSpeedValue
    end
end

-- Mencari indeks koordinat terdekat berdasarkan posisi karakter saat ini
local function getNearestWaypointIndex(character)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return 1 end

    local nearestDistance = math.huge
    local nearestIndex = 1

    for i, wp in ipairs(waypoints) do
        local pos1 = Vector3.new(rootPart.Position.X, 0, rootPart.Position.Z)
        local pos2 = Vector3.new(wp.pos.X, 0, wp.pos.Z)
        local distance = (pos1 - pos2).Magnitude

        if distance < nearestDistance then
            nearestDistance = distance
            nearestIndex = i
        end
    end
    return nearestIndex
end

local function startAutoPathing()
    while isAutoRunning do
        local character = LocalPlayer.Character
        
        -- Jika karakter mati atau belum respawn penuh
        if not character or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
            character = LocalPlayer.CharacterAdded:Wait()
            character:WaitForChild("HumanoidRootPart")
            character:WaitForChild("Humanoid")
            task.wait(0.5)
        end

        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

        applyStats(humanoid)
        local currentIndex = getNearestWaypointIndex(character)

        while isAutoRunning and currentIndex <= #waypoints do
            
            -- ===============================================
            -- SISTEM RE-CHECK JIKA TIBA-TIBA MATI
            -- ===============================================
            if not character or not character.Parent or humanoid.Health <= 0 then
                -- [TIMING TUNGGU SETELAH MATI]: Menunggu 5 detik penuh setelah terdeteksi mati
                task.wait(5) 
                
                -- Tunggu karakter benar-benar hidup kembali di tempat spawn baru
                character = LocalPlayer.CharacterAdded:Wait()
                rootPart = character:WaitForChild("HumanoidRootPart")
                humanoid = character:WaitForChild("Humanoid")
                task.wait(0.5) 
                
                -- Cari lagi koordinat paling dekat dari titik berdiri saat ini
                currentIndex = getNearestWaypointIndex(character)
                applyStats(humanoid)
                continue 
            end

            local target = waypoints[currentIndex]
            local stuckTimer = 0
            
            -- ===============================================
            -- FASE 1: JALAN MENUJU KOORDINAT TARGET
            -- ===============================================
            while isAutoRunning and humanoid.Health > 0 do
                local pos2D = Vector3.new(rootPart.Position.X, 0, rootPart.Position.Z)
                local target2D = Vector3.new(target.pos.X, 0, target.pos.Z)
                local distance = (pos2D - target2D).Magnitude
                
                -- Jarak toleransi di-set ke 5 karena kecepatan lari 80 sangat kencang
                if distance <= 5 then
                    break
                end

                humanoid:MoveTo(target.pos)
                task.wait(0.02)
                stuckTimer = stuckTimer + 0.02

                if stuckTimer > 3 then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    humanoid.Jump = true
                    stuckTimer = 0
                end
            end

            if humanoid.Health <= 0 or not isAutoRunning then continue end

            -- ===============================================
            -- FASE 2: LOMPAT PARABOLA PRESISI (ANTI-FALL / ANTI-MISSED)
            -- ===============================================
            if target.action == "Jump" then
                local nextTarget = waypoints[currentIndex + 1]
                
                if nextTarget then
                    local startPos = rootPart.Position
                    local endPos = nextTarget.pos
                    
                    -- Hitung jarak asli horizontal antar koordinat
                    local distance = (Vector3.new(startPos.X, 0, startPos.Z) - Vector3.new(endPos.X, 0, endPos.Z)).Magnitude
                    
                    -- DETEKSI JARAK: Jarak sempit = lompat sedikit, jarak jauh = lompat agak banyak
                    local jumpHeight = math.clamp(distance * 0.45, 12, 45) 
                    
                    -- Durasi melayang disesuaikan secara natural dengan kecepatan 80
                    local duration = math.max(distance / 80, 0.25) * 1.5
                    
                    -- Trigger animasi lompat agar terlihat asli
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    
                    -- Sistem gerak lengkungan (arc) parabola agar mendarat PAS di koordinat depannya
                    local t = 0
                    while t < 1 and humanoid.Health > 0 and isAutoRunning do
                        local dt = task.wait(0.01)
                        t = t + (dt / duration)
                        if t > 1 then t = 1 end
                        
                        -- Interpolasi posisi horizontal (X dan Z) & kalkulasi tinggi kurva (Y)
                        local currentXZ = startPos:Lerp(endPos, t)
                        local heightOffset = 4 * jumpHeight * t * (1 - t)
                        local currentY = startPos.Y + (endPos.Y - startPos.Y) * t + heightOffset
                        
                        -- Mengunci posisi dan arah hadap karakter ke koordinat depan selama melompat
                        rootPart.CFrame = CFrame.lookAt(
                            Vector3.new(currentXZ.X, currentY, currentXZ.Z), 
                            Vector3.new(endPos.X, currentY, endPos.Z)
                        )
                    end
                    
                    -- Mengunci posisi akhir mutlak di koordinat target pendaratan
                    if humanoid.Health > 0 then
                        rootPart.CFrame = CFrame.new(endPos)
                    end
                    task.wait(0.05)
                end
            end

            -- Index koordinat bertambah setelah sukses mendarat dengan selamat
            currentIndex = currentIndex + 1
        end

        task.wait(0.1)
    end
end

-- ==========================================
-- 3. INTERFACE WINDUI (BERSIH DARI SLIDER)
-- ==========================================
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "My Super Hub",
    Icon = "door-open",
    Author = "by .ftgs and .ftgs", 
})

local Tab = Window:Tab({
    Title = "Auto Farm",
    Icon = "bird",
    Locked = false,
})

local autoPathThread = nil

Tab:Toggle({
    Title = "Auto Path (Locked Speed 80)",
    Desc = "Lari otomatis & Sistem Lompat Presisi Parabola.",
    Icon = "footprints",
    Type = "Checkbox",
    Value = false, 
    Callback = function(state) 
        isAutoRunning = state
        if isAutoRunning then
            if autoPathThread then task.cancel(autoPathThread) end
            autoPathThread = task.spawn(startAutoPathing)
        else
            if autoPathThread then 
                task.cancel(autoPathThread) 
                autoPathThread = nil
            end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:MoveTo(char.HumanoidRootPart.Position)
            end
        end
    end
})
