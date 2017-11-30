allbinstarttimes = [];
allbinsamples = [];

for e = 1:length(EEG.epoch);
eventtimes = EEG.epoch(e).eventlatency(1:5);
eventtimes = cell2mat(eventtimes);
%All bin start samples (event, start/end, bin, epoch)
allbinstarttimes(:,1,1,e) = eventtimes;
allbinstarttimes(:,1,2,e) = eventtimes + 1000;
allbinstarttimes(:,1,3,e) = eventtimes + 2000;
allbinstarttimes(:,1,4,e) = eventtimes + 3000;
allbinstarttimes(:,1,5,e) = eventtimes + 4000;
allbinstarttimes(:,1,6,e) = eventtimes + 5000;
clear eventtimes e;
end


%All bin end samples
allbinsamples = allbinstarttimes(:,1,:,:)/4 + 1;
allbinstarttimes(:,2,:,:) = allbinstarttimes(:,1,:,:) + 996;
allbinsamples(:,2,:,:) = allbinstarttimes(:,2,:,:)/4 + 1;

allbinsamples(5,2,6,:) = 7500;

binneddata = zeros(257, 250, 5, 6, size(allbinsamples,4));
for epoch = 1:size(allbinsamples, 4);
	for bin = 1:size(allbinsamples, 3);
		for stp = 1:size(allbinsamples, 1);
			startsample = allbinsamples(stp,1,bin,epoch);
			endsample = allbinsamples(stp,2,bin,epoch);
			binneddata(:,:,stp,bin,epoch) = EEG.data(:, startsample:endsample, epoch);
			clear startsample endsample;
		end
	end
end


//
//
// for trial = 1:size(bin1timepoints,3);
// 	for bin1 = 1:5;
// 		bin1startsample = bin1timepoints(bin1,1,trial);
// 		bin1endsample = bin1timepoints(bin1,2,trial);
// 		bin1data(:,:,bin1,trial) = EEG.data(:,bin1startsample:bin1endsample,trial);
//
// 	end
//
// end
//
//
// %Trying things out:
//
// binned_data = [];
//
// for b = 1:6;
// 	for trial = 1:size(bin1timepoints,3);
// 		for bin1 = 1:5;
// 			bin1startsample = bin1timepoints(bin1,1,trial);
// 			bin1endsample = bin1timepoints(bin1,2,trial);
// 			bin1data(:,:,bin1,trial) = EEG.data(:,bin1startsample:bin1endsample,trial);
//
// 		end
//
// 	end
// end
