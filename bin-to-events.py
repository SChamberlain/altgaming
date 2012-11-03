import csv

time_range = "months" # days
path = "/Users/ian/Dropbox/alm12-sf-hackathon/"
test_file = path + "journal.pone.0042446.csv"

def read_data(file): # get the data from a local csv file
	data_points = []
	with open(file, 'rb') as csvfile:
		alm_reader = csv.reader(csvfile, delimiter=',')
		for row in alm_reader:
			data_points.append(row[1])
			print row
	return data_points

def un_cumulate_bins(cumulate_bins):
	# for data that is cumulative, convert it into bins
	un_cumulated = []
	current_value = 0
	last_value = 0
	for x in cumulate_bins:
		delta = int(x) - int(last_value)
		last_value = x 
		un_cumulated.append(delta)
	return un_cumulated

def bins_to_instances(instance_bins):
	return instance_stream

points = read_data(test_file)
un_cumulated = un_cumulate_bins(points)
print un_cumulated