import csv

time_range = "months" # days
path = "/Users/ian/Dropbox/alm12-sf-hackathon/"
test_file = path + "journal.pone.0042446.csv"
virtual_time = 10000 # an abstract time space to hoist events into, at an instance level.

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
	instance_bins = []
	current_value = 0
	last_value = 0
	for x in cumulate_bins:
		delta = int(x) - int(last_value)
		last_value = x 
		instance_bins.append(delta)
	return instance_bins

def calculate_time_per_bin(virtual_time, bins):
	return virtual_time / bins 

def bins_to_intervals(instance_bins, virtual_time):
	time_per_bin = virtual_time / len(instance_bins)
	intervals = []
	current_time = 0
	print_time = 0
	signals = []
	for bin in instance_bins: 
		if bin > time_per_bin:
			# there is not enough virtual time, we have a signal for every interval
			interval = 1
			print "OMFG, you are throwing away data, you crazy fool"
		else:
			if int(bin) == 0:
				# there is no signal, the interval is the entire allocation of virtual time
				interval = time_per_bin
			else:
				# we have a real signal that we jump along.
				interval = time_per_bin/int(bin)
		intervals.append(interval)
	return intervals

def intervals_to_signals(intervals, time_per_bin):
	print intervals, time_per_bin
	signals = []

points = read_data(test_file)
instance_bins = un_cumulate_bins(points)
intervals = bins_to_intervals(instance_bins, virtual_time)
time_per_bin = calculate_time_per_bin(virtual_time, len(instance_bins))
signals = intervals_to_signals(intervals, time_per_bin) 