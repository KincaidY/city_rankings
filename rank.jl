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
    locations = CSV.File(IOBuffer(join(data[:, 1], "\n")), header=[:zip, :city, :state], types=[String, String, String])
    locations = DataFrames.DataFrame(locations)
    data = CSV.File(IOBuffer(join(data[:, 2], "\n")), header=String.(split(strip(names(data)[2]))))
    data = DataFrames.DataFrame(data)
    data = hcat(locations, data)
    data[[:zip, :city, :state, :YRS]] = strip.(data[[:zip, :city, :state, :YRS]])
    data
end

function read_cloudy_data(path)
    data = CSV.read(path, delim="  ", ignorerepeated=true) # read as fixed width
    locations = CSV.File(IOBuffer(join(data[2:end, 1], "\n")), header=[:zip], types=[String])
    locations = DataFrames.DataFrame(locations)
    locations[:city] = SubString.(locations[:zip], 6)
    locations[:zip] = SubString.(locations[:zip], 1, 5)
    data = CSV.File(IOBuffer(join(strip.(data[2:end, 2]), "\n")), header=Symbol.(strip.(names(data))), delim=' ', ignorerepeated=true)
    data = DataFrames.DataFrame(data)
    data = hcat(locations, data)
    data
end

walk = CSV.read(joinpath(DATA_DIR, "walkscore.txt"), delim="\t")
precip = read_climate_norms(joinpath(DATA_DIR, "nrmpcp.txt"))
temps = read_climate_norms(joinpath(DATA_DIR, "nrmmax.txt"))
clouds = read_cloudy_data(joinpath(DATA_DIR, "clpcdy20.txt"))
