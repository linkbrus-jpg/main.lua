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
    {pos = Vector3.new(426.0, 1004.2, -3986.5), action = "Jump"},
    {pos = Vector3.new(418.8, 1005.4, -4009.3), action = "Jump"},
    {pos = Vector3.new(405.3, 991.9, -4035.2), action = "Jump"},
    {pos = Vector3.new(387.5, 976.6, -4063.0), action = "Jump"},
    {pos = Vector3.new(382.8, 963.5, -4101.4), action = "Jump"},
    {pos = Vector3.new(355.9, 951.0, -4113.2), action = "Jump"},
    {pos = Vector3.new(340.9, 940.2, -4145.7), action = "Jump"},
    {pos = Vector3.new(341.5, 927.1, -4171.9), action = "Jump"},
    {pos = Vector3.new(313.2, 914.6, -4188.9), action = "Jump"},
    {pos = Vector3.new(300.3, 908.5, -4215.1), action = "Jump"},
    {pos = Vector3.new(286.1, 897.7, -4240.6), action = "Jump"},
    {pos = Vector3.new(284.8, 899.6, -4271.2), action = "Jump"},
    {pos = Vector3.new(256.8, 902.3, -4292.5), action = "Jump"},
    {pos = Vector3.new(244.3, 908.4, -4316.3), action = "Jump"},
    {pos = Vector3.new(234.2, 903.8, -4338.1), action = "Run"},
    {pos = Vector3.new(-60.9, 903.0, -4765.3), action = "Jump"},
    {pos = Vector3.new(-69.1, 903.0, -4782.1), action = "Jump"},
    {pos = Vector3.new(-79.1, 905.0, -4800.9), action = "Jump"},
    {pos = Vector3.new(-88.8, 902.9, -4820.6), action = "Jump"},
    {pos = Vector3.new(-106.6, 906.4, -4835.3), action = "Jump"},
    {pos = Vector3.new(-106.1, 909.9, -4853.5), action = "Jump"},
    {pos = Vector3.new(-122.9, 913.9, -4868.7), action = "Jump"},
    {pos = Vector3.new(-126.6, 917.3, -4886.6), action = "Jump"},
    {pos = Vector3.new(-132.0, 921.3, -4907.8), action = "Jump"},
    {pos = Vector3.new(-134.5, 925.2, -4929.2), action = "Jump"},
    {pos = Vector3.new(-142.4, 929.2, -4946.8), action = "Jump"},
    {pos = Vector3.new(-157.5, 933.2, -4961.7), action = "Jump"},
    {pos = Vector3.new(-178.7, 932.4, -4970.8), action = "Jump"},
    {pos = Vector3.new(-186.6, 932.4, -4973.5), action = "Jump"},
    {pos = Vector3.new(-195.5, 932.4, -4977.4), action = "Jump"},
    {pos = Vector3.new(-203.2, 932.4, -4981.2), action = "Jump"},
    {pos = Vector3.new(-217.2, 933.4, -4983.9), action = "Jump"},
    {pos = Vector3.new(-238.0, 933.4, -4992.5), action = "Jump"},
    {pos = Vector3.new(-250.3, 937.4, -5014.7), action = "Jump"},
    {pos = Vector3.new(-269.0, 941.5, -5006.6), action = "Jump"},
    {pos = Vector3.new(-262.2, 945.5, -4987.2), action = "Jump"},
    {pos = Vector3.new(-244.4, 949.5, -4980.9), action = "Jump"},
    {pos = Vector3.new(-235.2, 953.4, -4994.3), action = "Jump"},
    {pos = Vector3.new(-232.6, 957.4, -5012.9), action = "Jump"},
    {pos = Vector3.new(-252.1, 961.4, -5020.5), action = "Jump"},
    {pos = Vector3.new(-270.2, 961.5, -5028.8), action = "Jump"},
    {pos = Vector3.new(-280.2, 961.7, -5032.8), action = "Jump"},
    {pos = Vector3.new(-289.2, 961.8, -5036.8), action = "Jump"},
    {pos = Vector3.new(-298.8, 961.8, -5040.5), action = "Jump"},
    {pos = Vector3.new(-312.9, 961.6, -5046.6), action = "Jump"},
    {pos = Vector3.new(-331.8, 965.6, -5053.7), action = "Jump"},
    {pos = Vector3.new(-359.6, 967.7, -5059.2), action = "Jump"},
    {pos = Vector3.new(-382.5, 970.3, -5066.3), action = "Jump"},
    {pos = Vector3.new(-399.4, 974.3, -5081.7), action = "Jump"},
    {pos = Vector3.new(-414.4, 978.3, -5088.5), action = "Jump"},
    {pos = Vector3.new(-432.0, 978.0, -5095.5), action = "Run"},
    {pos = Vector3.new(-745.8, 976.3, -5131.2), action = "Jump"},
    {pos = Vector3.new(-761.8, 978.7, -5133.3), action = "Jump"},
    {pos = Vector3.new(-775.5, 981.1, -5144.4), action = "Jump"},
    {pos = Vector3.new(-778.0, 981.5, -5159.1), action = "Jump"},
    {pos = Vector3.new(-786.2, 982.9, -5186.8), action = "Jump"},
    {pos = Vector3.new(-799.0, 985.1, -5191.9), action = "Jump"},
    {pos = Vector3.new(-812.5, 987.4, -5190.7), action = "Jump"},
    {pos = Vector3.new(-822.9, 989.2, -5180.3), action = "Jump"},
    {pos = Vector3.new(-826.8, 989.9, -5167.1), action = "Jump"},
    {pos = Vector3.new(-823.9, 989.4, -5154.6), action = "Jump"},
    {pos = Vector3.new(-815.9, 988.0, -5145.6), action = "Jump"},
    {pos = Vector3.new(-802.8, 985.8, -5138.5), action = "Jump"},
    {pos = Vector3.new(-795.2, 984.5, -5130.4), action = "Jump"},
    {pos = Vector3.new(-793.4, 984.2, -5115.7), action = "Jump"},
    {pos = Vector3.new(-798.9, 985.1, -5103.5), action = "Jump"},
    {pos = Vector3.new(-809.0, 986.8, -5096.3), action = "Jump"},
    {pos = Vector3.new(-824.5, 989.5, -5095.9), action = "Jump"},
    {pos = Vector3.new(-834.7, 991.2, -5102.1), action = "Jump"},
    {pos = Vector3.new(-840.7, 992.3, -5111.2), action = "Jump"},
    {pos = Vector3.new(-841.7, 992.4, -5125.5), action = "Jump"},
    {pos = Vector3.new(-843.2, 992.7, -5139.0), action = "Jump"},
    {pos = Vector3.new(-848.6, 993.6, -5147.5), action = "Jump"},
    {pos = Vector3.new(-857.6, 995.2, -5153.7), action = "Jump"},
    {pos = Vector3.new(-874.0, 998.0, -5154.0), action = "Jump"},
    {pos = Vector3.new(-885.0, 999.9, -5152.6), action = "Jump"},
    {pos = Vector3.new(-896.9, 1001.9, -5150.8), action = "Jump"},
    {pos = Vector3.new(-912.6, 1004.6, -5148.5), action = "Jump"},
    {pos = Vector3.new(-931.6, 1004.1, -5145.2), action = "Run"},
    {pos = Vector3.new(-1259.6, 1008.2, -5156.4), action = "Jump"},
    {pos = Vector3.new(-1269.9, 1009.9, -5172.4), action = "Jump"},
    {pos = Vector3.new(-1280.3, 1011.7, -5190.1), action = "Jump"},
    {pos = Vector3.new(-1288.0, 1013.0, -5207.0), action = "Jump"},
    {pos = Vector3.new(-1309.1, 1016.5, -5193.5), action = "Jump"},
    {pos = Vector3.new(-1334.1, 1020.7, -5194.1), action = "Jump"},
    {pos = Vector3.new(-1350.8, 1023.6, -5207.8), action = "Jump"},
    {pos = Vector3.new(-1373.1, 1027.3, -5193.4), action = "Jump"},
    {pos = Vector3.new(-1395.2, 1031.0, -5176.0), action = "Jump"},
    {pos = Vector3.new(-1414.0, 1034.2, -5189.8), action = "Jump"},
    {pos = Vector3.new(-1439.6, 1038.5, -5190.3), action = "Jump"},
    {pos = Vector3.new(-1455.7, 1041.2, -5176.2), action = "Jump"},
    {pos = Vector3.new(-1480.5, 1045.4, -5179.8), action = "Jump"},
    {pos = Vector3.new(-1479.4, 1045.2, -5207.3), action = "Jump"},
    {pos = Vector3.new(-1479.9, 1045.3, -5236.5), action = "Jump"},
    {pos = Vector3.new(-1494.2, 1047.7, -5236.4), action = "Jump"},
    {pos = Vector3.new(-1515.4, 1051.3, -5236.6), action = "Jump"},
    {pos = Vector3.new(-1530.5, 1053.8, -5236.6), action = "Jump"},
    {pos = Vector3.new(-1552.9, 1057.6, -5238.2), action = "Jump"},
    {pos = Vector3.new(-1551.9, 1057.4, -5207.5), action = "Jump"},
    {pos = Vector3.new(-1552.1, 1057.5, -5182.2), action = "Jump"},
    {pos = Vector3.new(-1567.7, 1060.1, -5180.1), action = "Jump"},
    {pos = Vector3.new(-1585.6, 1063.1, -5182.8), action = "Jump"},
    {pos = Vector3.new(-1604.0, 1066.2, -5204.5), action = "Jump"},
    {pos = Vector3.new(-1617.0, 1068.4, -5179.0), action = "Jump"},
    {pos = Vector3.new(-1655.8, 1074.9, -5180.5), action = "Run"},
    {pos = Vector3.new(-2004.3, 1074.6, -5180.8), action = "Jump"},
    {pos = Vector3.new(-2025.1, 1076.8, -5184.0), action = "Jump"},
    {pos = Vector3.new(-2039.9, 1083.8, -5165.8), action = "Jump"},
    {pos = Vector3.new(-2054.4, 1087.3, -5178.3), action = "Jump"},
    {pos = Vector3.new(-2072.7, 1093.8, -5158.6), action = "Jump"},
    {pos = Vector3.new(-2092.1, 1098.9, -5169.0), action = "Jump"},
    {pos = Vector3.new(-2105.1, 1105.0, -5150.2), action = "Jump"},
    {pos = Vector3.new(-2124.1, 1109.3, -5161.7), action = "Jump"},
    {pos = Vector3.new(-2134.7, 1115.9, -5141.9), action = "Jump"},
    {pos = Vector3.new(-2153.0, 1118.4, -5154.7), action = "Jump"},
    {pos = Vector3.new(-2168.4, 1126.4, -5134.2), action = "Jump"},
    {pos = Vector3.new(-2185.5, 1128.0, -5146.1), action = "Jump"},
    {pos = Vector3.new(-2198.6, 1135.0, -5128.2), action = "Jump"},
    {pos = Vector3.new(-2217.7, 1138.8, -5139.1), action = "Jump"},
    {pos = Vector3.new(-2232.1, 1145.4, -5120.5), action = "Jump"},
    {pos = Vector3.new(-2251.2, 1151.1, -5135.1), action = "Jump"},
    {pos = Vector3.new(-2265.2, 1155.3, -5113.4), action = "Jump"},
    {pos = Vector3.new(-2281.6, 1160.3, -5127.4), action = "Jump"},
    {pos = Vector3.new(-2296.7, 1164.5, -5106.9), action = "Jump"},
    {pos = Vector3.new(-2313.2, 1169.8, -5119.3), action = "Jump"},
    {pos = Vector3.new(-2326.9, 1174.2, -5099.7), action = "Jump"},
    {pos = Vector3.new(-2346.3, 1179.0, -5110.1), action = "Jump"},
    {pos = Vector3.new(-2360.4, 1186.0, -5090.8), action = "Jump"},
    {pos = Vector3.new(-2381.0, 1190.8, -5102.7), action = "Jump"},
    {pos = Vector3.new(-2402.6, 1193.9, -5092.8), action = "Run"},
    {pos = Vector3.new(-2555.3, 1192.7, -5038.6), action = "Jump"},
    {pos = Vector3.new(-2569.7, 1174.2, -5023.9), action = "Jump"},
    {pos = Vector3.new(-2598.3, 1174.2, -5016.4), action = "Jump"},
    {pos = Vector3.new(-2628.7, 1174.2, -5005.0), action = "Jump"},
    {pos = Vector3.new(-2656.3, 1174.2, -4997.3), action = "Jump"},
    {pos = Vector3.new(-2686.8, 1174.2, -5019.6), action = "Jump"},
    {pos = Vector3.new(-2715.2, 1174.2, -5009.0), action = "Jump"},
    {pos = Vector3.new(-2748.8, 1174.2, -5000.9), action = "Jump"},
    {pos = Vector3.new(-2774.1, 1174.2, -4991.4), action = "Jump"},
    {pos = Vector3.new(-2800.2, 1174.2, -4981.4), action = "Jump"},
    {pos = Vector3.new(-2796.2, 1174.2, -4945.6), action = "Jump"},
    {pos = Vector3.new(-2824.4, 1174.2, -4940.7), action = "Jump"},
    {pos = Vector3.new(-2852.2, 1174.2, -4931.6), action = "Jump"},
    {pos = Vector3.new(-2884.2, 1174.2, -4957.7), action = "Jump"},
    {pos = Vector3.new(-2914.3, 1174.2, -4946.7), action = "Jump"},
    {pos = Vector3.new(-2942.9, 1174.2, -4937.2), action = "Jump"},
    {pos = Vector3.new(-2968.1, 1174.2, -4929.8), action = "Jump"},
    {pos = Vector3.new(-3000.1, 1174.2, -4918.8), action = "Jump"},
    {pos = Vector3.new(-2989.1, 1174.2, -4884.1), action = "Jump"},
    {pos = Vector3.new(-3021.7, 1174.2, -4877.9), action = "Jump"},
    {pos = Vector3.new(-3051.2, 1174.2, -4867.9), action = "Jump"},
    {pos = Vector3.new(-3079.1, 1174.2, -4885.6), action = "Jump"},
    {pos = Vector3.new(-3108.8, 1174.2, -4880.4), action = "Jump"},
    {pos = Vector3.new(-3139.0, 1174.2, -4871.9), action = "Jump"},
    {pos = Vector3.new(-3162.9, 1174.2, -4859.8), action = "Jump"},
    {pos = Vector3.new(-3190.5, 1174.2, -4851.8), action = "Jump"},
    {pos = Vector3.new(-3189.2, 1174.2, -4820.9), action = "Jump"},
    {pos = Vector3.new(-3213.6, 1174.2, -4810.3), action = "Jump"},
    {pos = Vector3.new(-3243.3, 1174.2, -4800.8), action = "Jump"},
    {pos = Vector3.new(-3276.4, 1174.2, -4826.0), action = "Jump"},
    {pos = Vector3.new(-3301.3, 1174.2, -4815.5), action = "Jump"},
    {pos = Vector3.new(-3335.1, 1174.2, -4806.2), action = "Jump"},
    {pos = Vector3.new(-3363.5, 1174.2, -4796.3), action = "Jump"},
    {pos = Vector3.new(-3384.2, 1174.2, -4787.4), action = "Jump"},
    {pos = Vector3.new(-3382.0, 1174.2, -4753.6), action = "Jump"},
    {pos = Vector3.new(-3410.6, 1174.2, -4745.7), action = "Jump"},
    {pos = Vector3.new(-3439.0, 1174.2, -4736.1), action = "Run"},
    {pos = Vector3.new(-3546.3, 1169.1, -4530.4), action = "Run"},
    {pos = Vector3.new(-3506.7, 1200.9, -4447.6), action = "Run"},
    {pos = Vector3.new(-3536.2, 1222.6, -4366.9), action = "Run"},
    {pos = Vector3.new(-3429.4, 1231.5, -4391.8), action = "Run"},
    {pos = Vector3.new(-3458.4, 1253.0, -4311.9), action = "Run"},
    {pos = Vector3.new(-3348.4, 1281.6, -4276.8), action = "Run"},
    {pos = Vector3.new(-3315.0, 1281.6, -4208.2), action = "Run"},
    {pos = Vector3.new(-3045.0, 1282.0, -3940.3), action = "Run"},
    {pos = Vector3.new(-2880.2, 1288.3, -3901.9), action = "Run"},
    {pos = Vector3.new(-2726.0, 1341.5, -3805.3), action = "Run"},
    {pos = Vector3.new(-2648.8, 1358.6, -3772.3), action = "Run"},
    {pos = Vector3.new(-2581.5, 1354.0, -3764.7), action = "Run"},
    {pos = Vector3.new(-2387.0, 1352.6, -3460.1), action = "Jump"},
    {pos = Vector3.new(-2381.5, 1352.6, -3436.6), action = "Jump"},
    {pos = Vector3.new(-2376.5, 1352.6, -3409.3), action = "Jump"},
    {pos = Vector3.new(-2368.9, 1352.6, -3379.7), action = "Jump"},
    {pos = Vector3.new(-2362.5, 1352.6, -3353.8), action = "Jump"},
    {pos = Vector3.new(-2330.9, 1352.6, -3359.7), action = "Jump"},
    {pos = Vector3.new(-2327.0, 1352.6, -3331.2), action = "Jump"},
    {pos = Vector3.new(-2318.3, 1352.6, -3299.8), action = "Jump"},
    {pos = Vector3.new(-2310.2, 1352.6, -3271.7), action = "Jump"},
    {pos = Vector3.new(-2340.5, 1352.6, -3263.7), action = "Jump"},
    {pos = Vector3.new(-2333.7, 1352.6, -3230.7), action = "Jump"},
    {pos = Vector3.new(-2330.0, 1352.6, -3203.9), action = "Jump"},
    {pos = Vector3.new(-2322.6, 1352.6, -3176.5), action = "Jump"},
    {pos = Vector3.new(-2318.3, 1352.6, -3156.5), action = "Jump"},
    {pos = Vector3.new(-2314.7, 1352.6, -3128.6), action = "Jump"},
    {pos = Vector3.new(-2307.5, 1352.6, -3107.4), action = "Jump"},
    {pos = Vector3.new(-2278.1, 1352.6, -3114.7), action = "Jump"},
    {pos = Vector3.new(-2269.9, 1352.6, -3088.3), action = "Jump"},
    {pos = Vector3.new(-2238.2, 1352.6, -3074.9), action = "Jump"},
    {pos = Vector3.new(-2232.6, 1352.6, -3046.2), action = "Jump"},
    {pos = Vector3.new(-2227.3, 1352.6, -3022.1), action = "Jump"},
    {pos = Vector3.new(-2258.0, 1352.6, -3018.2), action = "Jump"},
    {pos = Vector3.new(-2251.5, 1352.6, -2991.9), action = "Jump"},
    {pos = Vector3.new(-2244.5, 1352.6, -2969.3), action = "Jump"},
    {pos = Vector3.new(-2263.3, 1352.6, -2939.1), action = "Jump"},
    {pos = Vector3.new(-2256.2, 1352.6, -2917.4), action = "Jump"},
    {pos = Vector3.new(-2253.7, 1352.6, -2892.0), action = "Jump"},
    {pos = Vector3.new(-2247.2, 1352.6, -2868.2), action = "Jump"},
    {pos = Vector3.new(-2243.3, 1352.6, -2848.1), action = "Jump"},
    {pos = Vector3.new(-2237.8, 1352.6, -2822.8), action = "Jump"},
    {pos = Vector3.new(-2233.9, 1356.6, -2801.6), action = "Jump"},
    {pos = Vector3.new(-2229.1, 1360.6, -2777.9), action = "Jump"},
    {pos = Vector3.new(-2208.0, 1364.6, -2782.0), action = "Jump"},
    {pos = Vector3.new(-2201.7, 1368.6, -2758.7), action = "Jump"},
    {pos = Vector3.new(-2194.0, 1372.6, -2732.2), action = "Jump"},
    {pos = Vector3.new(-2188.6, 1376.6, -2704.6), action = "Jump"},
    {pos = Vector3.new(-2182.7, 1380.6, -2676.3), action = "Jump"},
    {pos = Vector3.new(-2178.1, 1384.6, -2650.1), action = "Jump"},
    {pos = Vector3.new(-2170.3, 1388.6, -2623.9), action = "Run"},
    {pos = Vector3.new(-1990.0, 1384.9, -2323.0), action = "Jump"},
    {pos = Vector3.new(-1977.3, 1390.8, -2315.0), action = "Jump"},
    {pos = Vector3.new(-1951.6, 1390.8, -2297.1), action = "Jump"},
    {pos = Vector3.new(-1934.9, 1390.8, -2322.1), action = "Jump"},
    {pos = Vector3.new(-1910.2, 1390.8, -2306.5), action = "Jump"},
    {pos = Vector3.new(-1882.9, 1390.8, -2288.3), action = "Jump"},
    {pos = Vector3.new(-1877.1, 1390.8, -2247.2), action = "Jump"},
    {pos = Vector3.new(-1854.8, 1390.8, -2235.3), action = "Jump"},
    {pos = Vector3.new(-1820.3, 1390.8, -2251.8), action = "Jump"},
    {pos = Vector3.new(-1796.2, 1390.8, -2236.0), action = "Jump"},
    {pos = Vector3.new(-1804.4, 1390.8, -2201.6), action = "Jump"},
    {pos = Vector3.new(-1779.8, 1390.8, -2186.7), action = "Jump"},
    {pos = Vector3.new(-1757.5, 1397.3, -2178.6), action = "Jump"},
    {pos = Vector3.new(-1737.2, 1403.0, -2169.2), action = "Jump"},
    {pos = Vector3.new(-1730.5, 1411.0, -2185.7), action = "Jump"},
    {pos = Vector3.new(-1729.7, 1418.0, -2164.9), action = "Jump"},
    {pos = Vector3.new(-1724.5, 1425.0, -2179.4), action = "Jump"},
    {pos = Vector3.new(-1734.8, 1433.0, -2170.4), action = "Jump"},
    {pos = Vector3.new(-1725.2, 1440.0, -2179.4), action = "Jump"},
    {pos = Vector3.new(-1730.3, 1448.0, -2164.1), action = "Jump"},
    {pos = Vector3.new(-1725.6, 1455.0, -2178.5), action = "Jump"},
    {pos = Vector3.new(-1730.4, 1463.0, -2161.1), action = "Jump"},
    {pos = Vector3.new(-1725.0, 1470.0, -2178.1), action = "Jump"},
    {pos = Vector3.new(-1732.3, 1478.0, -2165.5), action = "Jump"},
    {pos = Vector3.new(-1725.9, 1485.0, -2178.2), action = "Jump"},
    {pos = Vector3.new(-1729.5, 1493.0, -2164.4), action = "Jump"},
    {pos = Vector3.new(-1723.5, 1500.0, -2178.0), action = "Jump"},
    {pos = Vector3.new(-1734.9, 1508.0, -2169.9), action = "Jump"},
    {pos = Vector3.new(-1721.8, 1515.0, -2178.8), action = "Jump"},
    {pos = Vector3.new(-1732.5, 1523.0, -2166.7), action = "Jump"},
    {pos = Vector3.new(-1720.8, 1530.0, -2175.8), action = "Jump"},
    {pos = Vector3.new(-1731.5, 1538.0, -2167.8), action = "Jump"},
    {pos = Vector3.new(-1715.7, 1545.0, -2172.1), action = "Jump"},
    {pos = Vector3.new(-1730.4, 1553.0, -2166.4), action = "Jump"},
    {pos = Vector3.new(-1723.9, 1560.0, -2178.1), action = "Jump"},
    {pos = Vector3.new(-1731.1, 1568.0, -2164.4), action = "Jump"},
    {pos = Vector3.new(-1723.9, 1575.0, -2176.6), action = "Jump"},
    {pos = Vector3.new(-1731.8, 1583.0, -2167.0), action = "Jump"},
    {pos = Vector3.new(-1726.7, 1590.0, -2178.0), action = "Jump"},
    {pos = Vector3.new(-1691.1, 1586.5, -2188.4), action = "Jump"},
    {pos = Vector3.new(-1664.2, 1580.6, -2200.9), action = "Jump"},
    {pos = Vector3.new(-1630.8, 1580.6, -2184.8), action = "Jump"},
    {pos = Vector3.new(-1595.6, 1574.9, -2195.7), action = "Run"},
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
