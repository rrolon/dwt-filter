# dwt-filter

A new filter to be applied to pulse oximetry signals.

## Example usage:

sampleStudy = load([pwd '/sampleData/200090.mat'],'SaO2','apn','Flujo');//
sampleSignal = sampleStudy.SaO2.signal;
sampleLabels = sampleStudy.apn;
sampleRateLabels = sampleStudy.Flujo.Fs;
sampleLabels = sampleLabels(1:sampleRateLabels:end);

[filteredSignal, filteredLabels] = waveletFiltering(sampleSignal, sampleLabels);

