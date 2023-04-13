using CSV
using DataFrames

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

function read_climate_norms(path)
    data = CSV.read(path, delim="    ")
    locations = CSV.File(IOBuffer(join(data["NORMALS 1981-2010"], "\n")), header=["zip", "city", "state"], types=[String, String, String])
    locations = DataFrames.DataFrame(data)
    data = CSV.File(IOBuffer(join(data["                 YRS  JAN   FEB   MAR   APR   MAY   JUN   JUL   AUG   SEP   OCT   NOV   DEC   ANN"], "\n")), header=["YRS", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC", "ANN"])
    data = DataFrames.DataFrame(data)
    data = hcat(precip_locations, data)
    data[["zip", "city", "state", "YRS"]] = strip.(data[["zip", "city", "state", "YRS"]])
    data
end

# function read_cloudy_data(path)

walk = CSV.read(joinpath(DATA_DIR, "walkscore.txt"), delim="\t")
precip = read_weather_data(joinpath(DATA_DIR, "nrmpcp.txt"))
temps = read_weather_data(joinpath(DATA_DIR, "nrmmax.txt"))
# clouds = read_weather_data(joinpath(DATA_DIR, "clpcdy20.txt"))
