using CSV

"""
pros - 
weather between 60 and 90
VRM per capita
bike score
walk score

cons -
rent
rainy days
weather below 30 or above 100
"""
DATA_DIR = "../"

walk = CSV.read(joinpath(DATA_DIR, "walkscore.txt"), delim="\t")
precip = CSV.read(joinpath(DATA_DIR, "nrmpcp.txt"), delim="    ")
precip_locations = CSV.File(IOBuffer(join(precip["NORMALS 1981-2010"], "\n")), header=["zip", "city", "state"])
precip_data = CSV.File(IOBuffer(join(precip["                 YRS  JAN   FEB   MAR   APR   MAY   JUN   JUL   AUG   SEP   OCT   NOV   DEC   ANN"], "\n")), header=["YRS", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC", "ANN"])
