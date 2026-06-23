local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Konfigurasi Statis (Kecepatan dikunci ke 80)
local walkSpeedValue = 60
local isAutoRunning = false

-- ==========================================
-- 1. KONFIGURASI KOORDINAT
-- ==========================================
local waypoints = {
    {pos = Vector3.new(349.4, 56.2, -1418.3), action = "Jump"},
    {pos = Vector3.new(340.5, 56.2, -1439.5), action = "Jump"},
    {pos = Vector3.new(326.3, 56.2, -1463.6), action = "Jump"},
    {pos = Vector3.new(304.3, 53.2, -1482.7), action = "Jump"},
    {pos = Vector3.new(306.0, 54.9, -1516.4), action = "Jump"}, 
    {pos = Vector3.new(288.1, 56.2, -1540.4), action = "Jump"}, 
    {pos = Vector3.new(267.2, 56.2, -1554.8), action = "Jump"},
    {pos = Vector3.new(251.1, 56.2, -1581.0), action = "Jump"},
    {pos = Vector3.new(233.7, 54.5, -1604.1), action = "Jump"},
    {pos = Vector3.new(217.4, 56.2, -1631.5), action = "Jump"},
    {pos = Vector3.new(202.8, 55.7, -1657.7), action = "Jump"},
    {pos = Vector3.new(199.0, 61.5, -1663.6), action = "Jump"},
    {pos = Vector3.new(171.9, 56.2, -1702.1), action = "Jump"},
    {pos = Vector3.new(156.4, 56.2, -1724.9), action = "Jump"},
    {pos = Vector3.new(141.1, 56.2, -1749.6), action = "Jump"},
    {pos = Vector3.new(127.3, 56.2, -1772.1), action = "Run"},
    {pos = Vector3.new(14.5, 53.4, -1941.1), action = "Jump"},
    {pos = Vector3.new(6.6, 58.4, -1969.0), action = "Jump"},
    {pos = Vector3.new(-20.5, 60.1, -1971.1), action = "Jump"},
    {pos = Vector3.new(-16.1, 58.6, -2001.4), action = "Jump"},
    {pos = Vector3.new(-43.7, 60.2, -2003.5), action = "Jump"},
    {pos = Vector3.new(-40.6, 58.6, -2035.7), action = "Jump"},
    {pos = Vector3.new(-69.3, 60.5, -2038.9), action = "Jump"},
    {pos = Vector3.new(-62.8, 60.6, -2070.4), action = "Jump"},
    {pos = Vector3.new(-92.3, 60.0, -2072.3), action = "Jump"},
    {pos = Vector3.new(-87.4, 59.7, -2103.4), action = "Jump"},
    {pos = Vector3.new(-115.9, 60.3, -2105.0), action = "Jump"},
    {pos = Vector3.new(-110.5, 59.1, -2135.1), action = "Jump"},
    {pos = Vector3.new(-138.9, 59.3, -2139.1), action = "Jump"},
    {pos = Vector3.new(-132.6, 60.1, -2167.9), action = "Jump"},
    {pos = Vector3.new(-163.6, 59.7, -2173.1), action = "Jump"},
    {pos = Vector3.new(-159.7, 58.7, -2203.5), action = "Jump"},
    {pos = Vector3.new(-180.3, 53.4, -2213.2), action = "Run"},
    {pos = Vector3.new(-237.8, 54.8, -2352.4), action = "Run"},
    {pos = Vector3.new(-240.3, 53.9, -2496.8), action = "Jump"},
    {pos = Vector3.new(-240.3, 55.0, -2520.0), action = "Jump"},
    {pos = Vector3.new(-240.3, 57.6, -2541.5), action = "Jump"},
    {pos = Vector3.new(-240.3, 59.0, -2563.0), action = "Jump"},
    {pos = Vector3.new(-240.2, 62.4, -2579.8), action = "Jump"},
    {pos = Vector3.new(-240.3, 65.8, -2602.5), action = "Jump"},
    {pos = Vector3.new(-240.4, 65.9, -2631.2), action = "Jump"},
    {pos = Vector3.new(-239.8, 65.9, -2670.3), action = "Jump"},
    {pos = Vector3.new(-239.9, 62.0, -2705.6), action = "Jump"},
    {pos = Vector3.new(-239.9, 50.5, -2747.0), action = "Jump"},
    {pos = Vector3.new(-271.9, 59.0, -2757.8), action = "Jump"},
    {pos = Vector3.new(-268.1, 57.0, -2796.7), action = "Jump"},
    {pos = Vector3.new(-271.2, 58.6, -2840.6), action = "Jump"},
    {pos = Vector3.new(-298.4, 55.0, -2880.4), action = "Jump"},
    {pos = Vector3.new(-337.5, 52.9, -2903.6), action = "Jump"},
    {pos = Vector3.new(-366.9, 55.0, -2908.3), action = "Jump"},
    {pos = Vector3.new(-384.2, 55.0, -2896.9), action = "Jump"},
    {pos = Vector3.new(-410.9, 55.0, -2909.4), action = "Run"},
    {pos = Vector3.new(-491.3, 54.0, -2918.6), action = "Run"},
    {pos = Vector3.new(-495.5, 129.3, -2924.0), action = "Run"},
    {pos = Vector3.new(-521.5, 130.0, -2948.0), action = "Run"},
    {pos = Vector3.new(-493.0, 130.0, -3002.7), action = "Run"},
    {pos = Vector3.new(-606.2, 130.0, -3043.8), action = "Run"},
    {pos = Vector3.new(-617.0, 125.8, -3054.5), action = "Jump"},
    {pos = Vector3.new(-636.5, 125.8, -3078.8), action = "Jump"},
    {pos = Vector3.new(-646.9, 125.8, -3104.9), action = "Jump"},
    {pos = Vector3.new(-650.7, 125.8, -3133.0), action = "Jump"},
    {pos = Vector3.new(-649.6, 125.8, -3152.7), action = "Jump"},
    {pos = Vector3.new(-646.2, 125.8, -3168.1), action = "Jump"},
    {pos = Vector3.new(-642.8, 125.8, -3188.2), action = "Jump"},
    {pos = Vector3.new(-641.7, 125.8, -3213.5), action = "Jump"},
    {pos = Vector3.new(-642.7, 125.8, -3233.0), action = "Jump"},
    {pos = Vector3.new(-641.2, 125.8, -3258.7), action = "Jump"},
    {pos = Vector3.new(-612.9, 125.8, -3311.8), action = "Jump"},
    {pos = Vector3.new(-573.7, 125.8, -3331.1), action = "Jump"},
    {pos = Vector3.new(-547.2, 125.8, -3342.5), action = "Jump"},
    {pos = Vector3.new(-527.8, 125.8, -3360.9), action = "Jump"},
    {pos = Vector3.new(-516.9, 125.8, -3381.9), action = "Jump"},
    {pos = Vector3.new(-511.5, 125.8, -3407.6), action = "Jump"},
    {pos = Vector3.new(-516.1, 125.5, -3437.6), action = "Jump"},
    {pos = Vector3.new(-536.2, 110.0, -3454.1), action = "Run"},
    {pos = Vector3.new(-539.9, 136.2, -3576.9), action = "Run"},
    {pos = Vector3.new(-527.5, 110.0, -3762.2), action = "Run"},
    {pos = Vector3.new(-528.7, 152.9, -3767.7), action = "Run"},
    {pos = Vector3.new(-528.2, 150.9, -3785.9), action = "Jump"},
    {pos = Vector3.new(-528.0, 157.8, -3816.7), action = "Jump"},
    {pos = Vector3.new(-528.3, 160.6, -3856.1), action = "Jump"},
    {pos = Vector3.new(-528.4, 166.3, -3900.3), action = "Jump"},
    {pos = Vector3.new(-527.2, 172.1, -3943.8), action = "Jump"},
    {pos = Vector3.new(-526.7, 165.5, -3982.5), action = "Jump"},
    {pos = Vector3.new(-529.2, 160.3, -4029.2), action = "Jump"},
    {pos = Vector3.new(-528.2, 155.9, -4072.5), action = "Jump"},
    {pos = Vector3.new(-527.3, 155.9, -4123.5), action = "Jump"},
    {pos = Vector3.new(-527.7, 155.4, -4174.2), action = "Jump"},
    {pos = Vector3.new(-527.7, 160.6, -4221.0), action = "Jump"},
    {pos = Vector3.new(-528.0, 166.2, -4265.7), action = "Jump"},
    {pos = Vector3.new(-526.6, 171.3, -4306.9), action = "Jump"},
    {pos = Vector3.new(-527.8, 166.3, -4348.2), action = "Jump"},
    {pos = Vector3.new(-528.0, 159.8, -4393.3), action = "Run"},
    {pos = Vector3.new(-516.1, 110.2, -4676.1), action = "Jump"},
    {pos = Vector3.new(-515.6, 110.2, -4720.9), action = "Jump"},
    {pos = Vector3.new(-516.0, 110.2, -4785.9), action = "Jump"},
    {pos = Vector3.new(-516.1, 110.2, -4842.6), action = "Jump"},
    {pos = Vector3.new(-516.3, 110.2, -4897.9), action = "Jump"},
    {pos = Vector3.new(-517.5, 110.2, -4955.8), action = "Jump"},
    {pos = Vector3.new(-518.1, 110.2, -5004.3), action = "Jump"},
    {pos = Vector3.new(-517.9, 110.2, -5055.2), action = "Jump"},
    {pos = Vector3.new(-517.8, 110.2, -5107.7), action = "Jump"},
    {pos = Vector3.new(-518.6, 110.0, -5159.0), action = "Run"},
    {pos = Vector3.new(-639.2, 110.0, -5272.7), action = "Jump"},
    {pos = Vector3.new(-664.1, 112.6, -5264.8), action = "Jump"},
    {pos = Vector3.new(-691.3, 116.2, -5259.4), action = "Jump"},
    {pos = Vector3.new(-718.2, 119.1, -5253.2), action = "Jump"},
    {pos = Vector3.new(-732.2, 120.6, -5229.8), action = "Jump"},
    {pos = Vector3.new(-759.3, 122.7, -5224.6), action = "Jump"},
    {pos = Vector3.new(-793.1, 126.6, -5238.8), action = "Jump"},
    {pos = Vector3.new(-811.4, 128.9, -5213.4), action = "Jump"},
    {pos = Vector3.new(-836.2, 129.0, -5208.7), action = "Jump"},
    {pos = Vector3.new(-869.3, 131.9, -5222.2), action = "Jump"},
    {pos = Vector3.new(-885.9, 131.4, -5198.5), action = "Jump"},
    {pos = Vector3.new(-914.0, 132.2, -5194.7), action = "Jump"},
    {pos = Vector3.new(-937.4, 132.4, -5207.3), action = "Jump"},
    {pos = Vector3.new(-974.5, 137.0, -5200.9), action = "Jump"},
    {pos = Vector3.new(-998.5, 138.2, -5196.1), action = "Jump"},
    {pos = Vector3.new(-1035.1, 140.4, -5196.7), action = "Jump"},
    {pos = Vector3.new(-1066.4, 140.8, -5182.6), action = "Jump"},
    {pos = Vector3.new(-1094.2, 143.3, -5178.1), action = "Jump"},
    {pos = Vector3.new(-1122.0, 144.5, -5177.9), action = "Jump"},
    {pos = Vector3.new(-1143.1, 144.5, -5163.2), action = "Jump"},
    {pos = Vector3.new(-1175.0, 147.6, -5168.7), action = "Jump"},
    {pos = Vector3.new(-1195.4, 148.8, -5164.2), action = "Run"},
    {pos = Vector3.new(-1396.4, 150.3, -5043.1), action = "Jump"},
    {pos = Vector3.new(-1413.9, 153.3, -5034.3), action = "Jump"},
    {pos = Vector3.new(-1435.1, 156.4, -5023.5), action = "Jump"},
    {pos = Vector3.new(-1463.4, 159.0, -5019.1), action = "Jump"},
    {pos = Vector3.new(-1475.8, 162.1, -5002.5), action = "Jump"},
    {pos = Vector3.new(-1496.7, 165.2, -4992.3), action = "Jump"},
    {pos = Vector3.new(-1519.2, 168.9, -4986.2), action = "Jump"},
    {pos = Vector3.new(-1542.3, 172.3, -4986.8), action = "Jump"},
    {pos = Vector3.new(-1566.2, 176.1, -4981.5), action = "Jump"},
    {pos = Vector3.new(-1591.7, 180.3, -4989.6), action = "Jump"},
    {pos = Vector3.new(-1611.7, 184.2, -5000.5), action = "Jump"},
    {pos = Vector3.new(-1630.7, 188.4, -4988.8), action = "Jump"},
    {pos = Vector3.new(-1653.4, 192.3, -4983.8), action = "Jump"},
    {pos = Vector3.new(-1676.6, 196.4, -4984.9), action = "Run"},
    {pos = Vector3.new(-1891.2, 196.5, -4958.6), action = "Jump"},
    {pos = Vector3.new(-1911.6, 196.6, -4951.4), action = "Jump"},
    {pos = Vector3.new(-1933.6, 200.0, -4939.8), action = "Jump"},
    {pos = Vector3.new(-1955.7, 203.4, -4927.0), action = "Jump"},
    {pos = Vector3.new(-1976.4, 206.8, -4911.2), action = "Jump"},
    {pos = Vector3.new(-1997.1, 210.6, -4891.5), action = "Jump"},
    {pos = Vector3.new(-2015.0, 213.5, -4877.9), action = "Jump"},
    {pos = Vector3.new(-2033.9, 216.6, -4865.5), action = "Jump"},
    {pos = Vector3.new(-2054.3, 219.6, -4856.1), action = "Jump"},
    {pos = Vector3.new(-2077.2, 222.9, -4847.3), action = "Jump"},
    {pos = Vector3.new(-2100.1, 225.8, -4843.2), action = "Jump"},
    {pos = Vector3.new(-2124.4, 228.9, -4840.6), action = "Jump"},
    {pos = Vector3.new(-2145.2, 231.3, -4841.1), action = "Jump"},
    {pos = Vector3.new(-2171.3, 234.4, -4841.1), action = "Jump"},
    {pos = Vector3.new(-2195.1, 237.2, -4841.2), action = "Jump"},
    {pos = Vector3.new(-2219.2, 240.2, -4838.7), action = "Jump"},
    {pos = Vector3.new(-2241.6, 243.1, -4834.1), action = "Jump"},
    {pos = Vector3.new(-2264.1, 246.2, -4827.1), action = "Jump"},
    {pos = Vector3.new(-2293.5, 250.6, -4813.1), action = "Run"},
    {pos = Vector3.new(-2586.3, 251.1, -4620.9), action = "Jump"},
    {pos = Vector3.new(-2605.0, 259.9, -4599.7), action = "Jump"},
    {pos = Vector3.new(-2627.5, 269.0, -4573.2), action = "Jump"},
    {pos = Vector3.new(-2629.3, 274.5, -4539.8), action = "Jump"},
    {pos = Vector3.new(-2663.5, 280.3, -4532.9), action = "Jump"},
    {pos = Vector3.new(-2704.3, 286.5, -4529.6), action = "Jump"},
    {pos = Vector3.new(-2727.4, 293.8, -4503.4), action = "Jump"},
    {pos = Vector3.new(-2747.2, 300.2, -4479.8), action = "Jump"},
    {pos = Vector3.new(-2766.8, 306.6, -4456.5), action = "Jump"},
    {pos = Vector3.new(-2789.3, 313.7, -4431.3), action = "Jump"},
    {pos = Vector3.new(-2792.3, 314.0, -4389.8), action = "Run"},
    {pos = Vector3.new(-2825.9, 314.0, -4154.1), action = "Run"},
    {pos = Vector3.new(-2780.8, 315.4, -4064.6), action = "Run"},
    {pos = Vector3.new(-2731.4, 315.4, -3967.2), action = "Run"},
    {pos = Vector3.new(-2662.4, 359.8, -3829.5), action = "Run"},
    {pos = Vector3.new(-2644.2, 360.6, -3796.2), action = "Run"},
    {pos = Vector3.new(-2658.2, 362.0, -3641.5), action = "Jump"},
    {pos = Vector3.new(-2648.0, 366.6, -3631.4), action = "Jump"},
    {pos = Vector3.new(-2630.7, 372.2, -3629.7), action = "Jump"},
    {pos = Vector3.new(-2630.6, 378.1, -3645.4), action = "Jump"},
    {pos = Vector3.new(-2648.1, 383.9, -3645.1), action = "Jump"},
    {pos = Vector3.new(-2646.1, 389.8, -3630.4), action = "Jump"},
    {pos = Vector3.new(-2629.7, 395.7, -3630.6), action = "Jump"},
    {pos = Vector3.new(-2630.7, 401.6, -3645.0), action = "Jump"},
    {pos = Vector3.new(-2646.9, 407.5, -3646.4), action = "Jump"},
    {pos = Vector3.new(-2646.8, 413.3, -3630.4), action = "Jump"},
    {pos = Vector3.new(-2631.2, 419.2, -3629.3), action = "Jump"},
    {pos = Vector3.new(-2629.7, 425.1, -3647.4), action = "Jump"},
    {pos = Vector3.new(-2644.6, 431.0, -3647.9), action = "Jump"},
    {pos = Vector3.new(-2647.0, 436.8, -3630.5), action = "Jump"},
    {pos = Vector3.new(-2631.0, 442.7, -3629.4), action = "Jump"},
    {pos = Vector3.new(-2629.4, 448.6, -3643.7), action = "Jump"},
    {pos = Vector3.new(-2643.3, 454.5, -3648.4), action = "Jump"},
    {pos = Vector3.new(-2646.7, 460.4, -3631.6), action = "Jump"},
    {pos = Vector3.new(-2630.8, 466.6, -3629.8), action = "Jump"},
    {pos = Vector3.new(-2628.6, 472.6, -3644.9), action = "Jump"},
    {pos = Vector3.new(-2647.2, 478.4, -3643.9), action = "Jump"},
    {pos = Vector3.new(-2645.7, 484.3, -3631.4), action = "Jump"},
    {pos = Vector3.new(-2631.1, 490.2, -3630.4), action = "Jump"},
    {pos = Vector3.new(-2628.8, 496.1, -3644.6), action = "Jump"},
    {pos = Vector3.new(-2644.8, 501.9, -3646.0), action = "Jump"},
    {pos = Vector3.new(-2644.8, 507.8, -3631.9), action = "Jump"},
    {pos = Vector3.new(-2633.2, 507.8, -3617.2), action = "Run"},
    {pos = Vector3.new(-2457.5, 505.8, -3526.5), action = "Run"},
    {pos = Vector3.new(-2454.4, 610.3, -3524.6), action = "Run"},
    {pos = Vector3.new(-2376.2, 609.7, -3448.0), action = "Run"},
    {pos = Vector3.new(-2409.4, 609.7, -3413.0), action = "Run"},
    {pos = Vector3.new(-2336.6, 609.8, -3336.7), action = "Run"},
    {pos = Vector3.new(-2331.7, 714.6, -3336.8), action = "Run"},
    {pos = Vector3.new(-2261.2, 745.4, -3265.8), action = "Run"},
    {pos = Vector3.new(-2239.4, 745.4, -3286.9), action = "Run"},
    {pos = Vector3.new(-2197.7, 777.2, -3244.5), action = "Run"},
    {pos = Vector3.new(-1926.7, 777.8, -3109.5), action = "Run"},
    {pos = Vector3.new(-1873.7, 791.2, -3107.5), action = "Run"},
    {pos = Vector3.new(-1838.6, 804.2, -3127.3), action = "Jump"},
    {pos = Vector3.new(-1821.2, 809.2, -3140.1), action = "Run"},
    {pos = Vector3.new(-1810.1, 808.6, -3121.5), action = "Run"},
    {pos = Vector3.new(-1801.5, 810.8, -3126.0), action = "Run"},
    {pos = Vector3.new(-1700.2, 834.6, -3124.1), action = "Run"},
    {pos = Vector3.new(-1690.2, 837.1, -3130.2), action = "Run"},
    {pos = Vector3.new(-1680.5, 840.4, -3111.0), action = "Run"},
    {pos = Vector3.new(-1666.4, 844.1, -3119.3), action = "Run"},
    {pos = Vector3.new(-1344.7, 835.2, -3101.2), action = "Run"},
    {pos = Vector3.new(-1299.6, 836.1, -3101.6), action = "Jump"},
    {pos = Vector3.new(-1289.8, 836.1, -3100.9), action = "Run"},
    {pos = Vector3.new(-1258.7, 836.1, -3101.3), action = "Run"},
    {pos = Vector3.new(-1257.9, 836.1, -3075.0), action = "Run"},
    {pos = Vector3.new(-1195.2, 836.1, -3075.1), action = "Jump"},
    {pos = Vector3.new(-1182.8, 836.1, -3075.6), action = "Run"},
    {pos = Vector3.new(-1160.6, 836.1, -3075.5), action = "Jump"},
    {pos = Vector3.new(-1133.4, 841.7, -3077.5), action = "Jump"},
    {pos = Vector3.new(-1148.7, 847.6, -3095.1), action = "Jump"},
    {pos = Vector3.new(-1165.3, 853.4, -3078.6), action = "Jump"},
    {pos = Vector3.new(-1149.5, 859.2, -3066.0), action = "Jump"},
    {pos = Vector3.new(-1134.2, 865.2, -3077.7), action = "Jump"},
    {pos = Vector3.new(-1150.4, 871.1, -3091.0), action = "Jump"},
    {pos = Vector3.new(-1161.3, 877.0, -3078.9), action = "Jump"},
    {pos = Vector3.new(-1148.5, 882.7, -3065.0), action = "Jump"},
    {pos = Vector3.new(-1134.9, 888.7, -3077.9), action = "Jump"},
    {pos = Vector3.new(-1148.5, 894.6, -3090.4), action = "Jump"},
    {pos = Vector3.new(-1161.0, 900.5, -3079.7), action = "Jump"},
    {pos = Vector3.new(-1147.7, 906.2, -3066.6), action = "Jump"},
    {pos = Vector3.new(-1134.6, 912.2, -3078.2), action = "Jump"},
    {pos = Vector3.new(-1149.3, 918.1, -3091.7), action = "Jump"},
    {pos = Vector3.new(-1161.1, 924.0, -3078.2), action = "Jump"},
    {pos = Vector3.new(-1149.3, 930.1, -3067.0), action = "Jump"},
    {pos = Vector3.new(-1133.9, 936.1, -3076.8), action = "Jump"},
    {pos = Vector3.new(-1113.9, 939.9, -3075.6), action = "Jump"},
    {pos = Vector3.new(-1095.1, 947.3, -3075.2), action = "Jump"},
    {pos = Vector3.new(-1073.7, 955.8, -3095.8), action = "Jump"},
    {pos = Vector3.new(-1058.6, 961.7, -3078.2), action = "Jump"},
    {pos = Vector3.new(-1035.4, 970.0, -3077.8), action = "Run"},
    {pos = Vector3.new(-714.3, 968.9, -3086.5), action = "Jump"},
    {pos = Vector3.new(-698.5, 973.6, -3086.6), action = "Jump"},
    {pos = Vector3.new(-672.6, 985.6, -3089.2), action = "Jump"},
    {pos = Vector3.new(-644.7, 989.7, -3086.1), action = "Jump"},
    {pos = Vector3.new(-625.2, 995.1, -3087.4), action = "Jump"},
    {pos = Vector3.new(-594.8, 995.0, -3085.5), action = "Jump"},
    {pos = Vector3.new(-578.0, 995.1, -3106.0), action = "Jump"},
    {pos = Vector3.new(-576.0, 995.0, -3129.4), action = "Jump"},
    {pos = Vector3.new(-556.2, 998.4, -3139.3), action = "Jump"},
    {pos = Vector3.new(-533.3, 995.9, -3152.4), action = "Jump"},
    {pos = Vector3.new(-519.0, 996.9, -3132.9), action = "Jump"},
    {pos = Vector3.new(-492.5, 995.0, -3133.2), action = "Jump"},
    {pos = Vector3.new(-471.2, 993.9, -3116.2), action = "Jump"},
    {pos = Vector3.new(-442.0, 990.9, -3099.8), action = "Jump"},
    {pos = Vector3.new(-424.8, 986.4, -3088.4), action = "Jump"},
    {pos = Vector3.new(-402.6, 980.8, -3076.7), action = "Jump"},
    {pos = Vector3.new(-390.4, 981.0, -3094.3), action = "Jump"},
    {pos = Vector3.new(-368.9, 976.6, -3080.2), action = "Run"},
    {pos = Vector3.new(-326.8, 950.4, -3074.2), action = "Run"},
    {pos = Vector3.new(-307.9, 952.7, -3076.6), action = "Jump"},
    {pos = Vector3.new(-270.0, 1310.0, -3084.4), action = "Run"},
    {pos = Vector3.new(-57.3, 1309.9, -3250.4), action = "Run"},
    {pos = Vector3.new(116.0, 1221.5, -3381.7), action = "Jump"},
    {pos = Vector3.new(127.4, 1241.7, -3368.4), action = "Run"},
    {pos = Vector3.new(188.5, 1239.1, -3413.4), action = "Jump"},
    {pos = Vector3.new(182.4, 1236.9, -3432.2), action = "Run"},
    {pos = Vector3.new(430.4, 1118.3, -3618.3), action = "Run"},
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
                    local duration = math.max(distance / 80, 0.25)
                    
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
