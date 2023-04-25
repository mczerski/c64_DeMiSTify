library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"7f000040",
     1 => x"7f19097f",
     2 => x"26000066",
     3 => x"7b594d6f",
     4 => x"01000032",
     5 => x"017f7f01",
     6 => x"3f000001",
     7 => x"7f40407f",
     8 => x"0f00003f",
     9 => x"3f70703f",
    10 => x"7f7f000f",
    11 => x"7f301830",
    12 => x"6341007f",
    13 => x"361c1c36",
    14 => x"03014163",
    15 => x"067c7c06",
    16 => x"71610103",
    17 => x"43474d59",
    18 => x"00000041",
    19 => x"41417f7f",
    20 => x"03010000",
    21 => x"30180c06",
    22 => x"00004060",
    23 => x"7f7f4141",
    24 => x"0c080000",
    25 => x"0c060306",
    26 => x"80800008",
    27 => x"80808080",
    28 => x"00000080",
    29 => x"04070300",
    30 => x"20000000",
    31 => x"7c545474",
    32 => x"7f000078",
    33 => x"7c44447f",
    34 => x"38000038",
    35 => x"4444447c",
    36 => x"38000000",
    37 => x"7f44447c",
    38 => x"3800007f",
    39 => x"5c54547c",
    40 => x"04000018",
    41 => x"05057f7e",
    42 => x"18000000",
    43 => x"fca4a4bc",
    44 => x"7f00007c",
    45 => x"7c04047f",
    46 => x"00000078",
    47 => x"407d3d00",
    48 => x"80000000",
    49 => x"7dfd8080",
    50 => x"7f000000",
    51 => x"6c38107f",
    52 => x"00000044",
    53 => x"407f3f00",
    54 => x"7c7c0000",
    55 => x"7c0c180c",
    56 => x"7c000078",
    57 => x"7c04047c",
    58 => x"38000078",
    59 => x"7c44447c",
    60 => x"fc000038",
    61 => x"3c2424fc",
    62 => x"18000018",
    63 => x"fc24243c",
    64 => x"7c0000fc",
    65 => x"0c04047c",
    66 => x"48000008",
    67 => x"7454545c",
    68 => x"04000020",
    69 => x"44447f3f",
    70 => x"3c000000",
    71 => x"7c40407c",
    72 => x"1c00007c",
    73 => x"3c60603c",
    74 => x"7c3c001c",
    75 => x"7c603060",
    76 => x"6c44003c",
    77 => x"6c381038",
    78 => x"1c000044",
    79 => x"3c60e0bc",
    80 => x"4400001c",
    81 => x"4c5c7464",
    82 => x"08000044",
    83 => x"41773e08",
    84 => x"00000041",
    85 => x"007f7f00",
    86 => x"41000000",
    87 => x"083e7741",
    88 => x"01020008",
    89 => x"02020301",
    90 => x"7f7f0001",
    91 => x"7f7f7f7f",
    92 => x"0808007f",
    93 => x"3e3e1c1c",
    94 => x"7f7f7f7f",
    95 => x"1c1c3e3e",
    96 => x"10000808",
    97 => x"187c7c18",
    98 => x"10000010",
    99 => x"307c7c30",
   100 => x"30100010",
   101 => x"1e786060",
   102 => x"66420006",
   103 => x"663c183c",
   104 => x"38780042",
   105 => x"6cc6c26a",
   106 => x"00600038",
   107 => x"00006000",
   108 => x"5e0e0060",
   109 => x"0e5d5c5b",
   110 => x"c24c711e",
   111 => x"4dbffdf0",
   112 => x"1ec04bc0",
   113 => x"c702ab74",
   114 => x"48a6c487",
   115 => x"87c578c0",
   116 => x"c148a6c4",
   117 => x"1e66c478",
   118 => x"dfee4973",
   119 => x"c086c887",
   120 => x"efef49e0",
   121 => x"4aa5c487",
   122 => x"f0f0496a",
   123 => x"87c6f187",
   124 => x"83c185cb",
   125 => x"04abb7c8",
   126 => x"2687c7ff",
   127 => x"4c264d26",
   128 => x"4f264b26",
   129 => x"c24a711e",
   130 => x"c25ac1f1",
   131 => x"c748c1f1",
   132 => x"ddfe4978",
   133 => x"1e4f2687",
   134 => x"4a711e73",
   135 => x"03aab7c0",
   136 => x"d5c287d3",
   137 => x"c405bff1",
   138 => x"c24bc187",
   139 => x"c24bc087",
   140 => x"c45bf5d5",
   141 => x"f5d5c287",
   142 => x"f1d5c25a",
   143 => x"9ac14abf",
   144 => x"49a2c0c1",
   145 => x"fc87e8ec",
   146 => x"f1d5c248",
   147 => x"effe78bf",
   148 => x"4a711e87",
   149 => x"721e66c4",
   150 => x"87e2e649",
   151 => x"1e4f2626",
   152 => x"bff1d5c2",
   153 => x"87c4e349",
   154 => x"48f5f0c2",
   155 => x"c278bfe8",
   156 => x"ec48f1f0",
   157 => x"f0c278bf",
   158 => x"494abff5",
   159 => x"c899ffc3",
   160 => x"48722ab7",
   161 => x"f0c2b071",
   162 => x"4f2658fd",
   163 => x"5c5b5e0e",
   164 => x"4b710e5d",
   165 => x"c287c8ff",
   166 => x"c048f0f0",
   167 => x"e2497350",
   168 => x"497087ea",
   169 => x"cb9cc24c",
   170 => x"cccb49ee",
   171 => x"4d497087",
   172 => x"97f0f0c2",
   173 => x"e2c105bf",
   174 => x"4966d087",
   175 => x"bff9f0c2",
   176 => x"87d60599",
   177 => x"c24966d4",
   178 => x"99bff1f0",
   179 => x"7387cb05",
   180 => x"87f8e149",
   181 => x"c1029870",
   182 => x"4cc187c1",
   183 => x"7587c0fe",
   184 => x"87e1ca49",
   185 => x"c6029870",
   186 => x"f0f0c287",
   187 => x"c250c148",
   188 => x"bf97f0f0",
   189 => x"87e3c005",
   190 => x"bff9f0c2",
   191 => x"9966d049",
   192 => x"87d6ff05",
   193 => x"bff1f0c2",
   194 => x"9966d449",
   195 => x"87caff05",
   196 => x"f7e04973",
   197 => x"05987087",
   198 => x"7487fffe",
   199 => x"87dcfb48",
   200 => x"5c5b5e0e",
   201 => x"86f40e5d",
   202 => x"ec4c4dc0",
   203 => x"a6c47ebf",
   204 => x"fdf0c248",
   205 => x"1ec178bf",
   206 => x"49c71ec0",
   207 => x"c887cdfd",
   208 => x"02987086",
   209 => x"49ff87ce",
   210 => x"c187ccfb",
   211 => x"dfff49da",
   212 => x"4dc187fa",
   213 => x"97f0f0c2",
   214 => x"87c302bf",
   215 => x"c287c4d0",
   216 => x"4bbff5f0",
   217 => x"bff1d5c2",
   218 => x"87ebc005",
   219 => x"ff49fdc3",
   220 => x"c387d9df",
   221 => x"dfff49fa",
   222 => x"497387d2",
   223 => x"7199ffc3",
   224 => x"fb49c01e",
   225 => x"497387cb",
   226 => x"7129b7c8",
   227 => x"fa49c11e",
   228 => x"86c887ff",
   229 => x"c287c0c6",
   230 => x"4bbff9f0",
   231 => x"87dd029b",
   232 => x"bfedd5c2",
   233 => x"87ddc749",
   234 => x"c4059870",
   235 => x"d24bc087",
   236 => x"49e0c287",
   237 => x"c287c2c7",
   238 => x"c658f1d5",
   239 => x"edd5c287",
   240 => x"7378c048",
   241 => x"0599c249",
   242 => x"ebc387ce",
   243 => x"fbddff49",
   244 => x"c2497087",
   245 => x"87c20299",
   246 => x"49734cfb",
   247 => x"ce0599c1",
   248 => x"49f4c387",
   249 => x"87e4ddff",
   250 => x"99c24970",
   251 => x"fa87c202",
   252 => x"c849734c",
   253 => x"87ce0599",
   254 => x"ff49f5c3",
   255 => x"7087cddd",
   256 => x"0299c249",
   257 => x"f1c287d5",
   258 => x"ca02bfc1",
   259 => x"88c14887",
   260 => x"58c5f1c2",
   261 => x"ff87c2c0",
   262 => x"734dc14c",
   263 => x"0599c449",
   264 => x"f2c387ce",
   265 => x"e3dcff49",
   266 => x"c2497087",
   267 => x"87dc0299",
   268 => x"bfc1f1c2",
   269 => x"b7c7487e",
   270 => x"cbc003a8",
   271 => x"c1486e87",
   272 => x"c5f1c280",
   273 => x"87c2c058",
   274 => x"4dc14cfe",
   275 => x"ff49fdc3",
   276 => x"7087f9db",
   277 => x"0299c249",
   278 => x"f1c287d5",
   279 => x"c002bfc1",
   280 => x"f1c287c9",
   281 => x"78c048c1",
   282 => x"fd87c2c0",
   283 => x"c34dc14c",
   284 => x"dbff49fa",
   285 => x"497087d6",
   286 => x"c00299c2",
   287 => x"f1c287d9",
   288 => x"c748bfc1",
   289 => x"c003a8b7",
   290 => x"f1c287c9",
   291 => x"78c748c1",
   292 => x"fc87c2c0",
   293 => x"c04dc14c",
   294 => x"c003acb7",
   295 => x"66c487d1",
   296 => x"82d8c14a",
   297 => x"c6c0026a",
   298 => x"744b6a87",
   299 => x"c00f7349",
   300 => x"1ef0c31e",
   301 => x"f749dac1",
   302 => x"86c887d2",
   303 => x"c0029870",
   304 => x"a6c887e2",
   305 => x"c1f1c248",
   306 => x"66c878bf",
   307 => x"c491cb49",
   308 => x"80714866",
   309 => x"bf6e7e70",
   310 => x"87c8c002",
   311 => x"c84bbf6e",
   312 => x"0f734966",
   313 => x"c0029d75",
   314 => x"f1c287c8",
   315 => x"f349bfc1",
   316 => x"d5c287c0",
   317 => x"c002bff5",
   318 => x"c24987dd",
   319 => x"987087c7",
   320 => x"87d3c002",
   321 => x"bfc1f1c2",
   322 => x"87e6f249",
   323 => x"c6f449c0",
   324 => x"f5d5c287",
   325 => x"f478c048",
   326 => x"87e0f38e",
   327 => x"5c5b5e0e",
   328 => x"711e0e5d",
   329 => x"fdf0c24c",
   330 => x"cdc149bf",
   331 => x"d1c14da1",
   332 => x"747e6981",
   333 => x"87cf029c",
   334 => x"744ba5c4",
   335 => x"fdf0c27b",
   336 => x"fff249bf",
   337 => x"747b6e87",
   338 => x"87c4059c",
   339 => x"87c24bc0",
   340 => x"49734bc1",
   341 => x"d487c0f3",
   342 => x"87c70266",
   343 => x"7087da49",
   344 => x"c087c24a",
   345 => x"f9d5c24a",
   346 => x"cff2265a",
   347 => x"00000087",
   348 => x"00000000",
   349 => x"00000000",
   350 => x"4a711e00",
   351 => x"49bfc8ff",
   352 => x"2648a172",
   353 => x"c8ff1e4f",
   354 => x"c0fe89bf",
   355 => x"c0c0c0c0",
   356 => x"87c401a9",
   357 => x"87c24ac0",
   358 => x"48724ac1",
   359 => x"5e0e4f26",
   360 => x"0e5d5c5b",
   361 => x"d4ff4b71",
   362 => x"4866d04c",
   363 => x"49d678c0",
   364 => x"87d0d8ff",
   365 => x"6c7cffc3",
   366 => x"99ffc349",
   367 => x"c3494d71",
   368 => x"e0c199f0",
   369 => x"87cb05a9",
   370 => x"6c7cffc3",
   371 => x"d098c348",
   372 => x"c3780866",
   373 => x"4a6c7cff",
   374 => x"c331c849",
   375 => x"4a6c7cff",
   376 => x"4972b271",
   377 => x"ffc331c8",
   378 => x"714a6c7c",
   379 => x"c84972b2",
   380 => x"7cffc331",
   381 => x"b2714a6c",
   382 => x"c048d0ff",
   383 => x"9b7378e0",
   384 => x"7287c202",
   385 => x"2648757b",
   386 => x"264c264d",
   387 => x"1e4f264b",
   388 => x"5e0e4f26",
   389 => x"f80e5c5b",
   390 => x"c81e7686",
   391 => x"fdfd49a6",
   392 => x"7086c487",
   393 => x"c2486e4b",
   394 => x"f0c203a8",
   395 => x"c34a7387",
   396 => x"d0c19af0",
   397 => x"87c702aa",
   398 => x"05aae0c1",
   399 => x"7387dec2",
   400 => x"0299c849",
   401 => x"c6ff87c3",
   402 => x"c34c7387",
   403 => x"05acc29c",
   404 => x"c487c2c1",
   405 => x"31c94966",
   406 => x"66c41e71",
   407 => x"c292d44a",
   408 => x"7249c5f1",
   409 => x"f7cdfe81",
   410 => x"ff49d887",
   411 => x"c887d5d5",
   412 => x"dfc21ec0",
   413 => x"e9fd49de",
   414 => x"d0ff87f2",
   415 => x"78e0c048",
   416 => x"1ededfc2",
   417 => x"d44a66cc",
   418 => x"c5f1c292",
   419 => x"fe817249",
   420 => x"cc87fecb",
   421 => x"05acc186",
   422 => x"c487c2c1",
   423 => x"31c94966",
   424 => x"66c41e71",
   425 => x"c292d44a",
   426 => x"7249c5f1",
   427 => x"efccfe81",
   428 => x"dedfc287",
   429 => x"4a66c81e",
   430 => x"f1c292d4",
   431 => x"817249c5",
   432 => x"87fec9fe",
   433 => x"d3ff49d7",
   434 => x"c0c887fa",
   435 => x"dedfc21e",
   436 => x"f0e7fd49",
   437 => x"ff86cc87",
   438 => x"e0c048d0",
   439 => x"fc8ef878",
   440 => x"5e0e87e7",
   441 => x"0e5d5c5b",
   442 => x"ff4d711e",
   443 => x"66d44cd4",
   444 => x"b7c3487e",
   445 => x"87c506a8",
   446 => x"e2c148c0",
   447 => x"fe497587",
   448 => x"7587c3db",
   449 => x"4b66c41e",
   450 => x"f1c293d4",
   451 => x"497383c5",
   452 => x"87fac3fe",
   453 => x"4b6b83c8",
   454 => x"c848d0ff",
   455 => x"7cdd78e1",
   456 => x"ffc34973",
   457 => x"737c7199",
   458 => x"29b7c849",
   459 => x"7199ffc3",
   460 => x"d049737c",
   461 => x"ffc329b7",
   462 => x"737c7199",
   463 => x"29b7d849",
   464 => x"7cc07c71",
   465 => x"7c7c7c7c",
   466 => x"7c7c7c7c",
   467 => x"c07c7c7c",
   468 => x"66c478e0",
   469 => x"ff49dc1e",
   470 => x"c887ced2",
   471 => x"26487386",
   472 => x"1e87e4fa",
   473 => x"bff1dec2",
   474 => x"c2b9c149",
   475 => x"ff59f5de",
   476 => x"ffc348d4",
   477 => x"48d0ff78",
   478 => x"ff78e1c0",
   479 => x"78c148d4",
   480 => x"787131c4",
   481 => x"c048d0ff",
   482 => x"4f2678e0",
   483 => x"e5dec21e",
   484 => x"d4ecc21e",
   485 => x"f5c1fe49",
   486 => x"7086c487",
   487 => x"87c30298",
   488 => x"2687c0ff",
   489 => x"4b35314f",
   490 => x"20205a48",
   491 => x"47464320",
   492 => x"00000000",
   493 => x"00000000",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;
