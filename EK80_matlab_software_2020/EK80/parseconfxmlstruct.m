% Parse Configuration XML data to a Configuration Matlab structure
% Simrad, Lars Nonboe Andersen, 10/10-13

function confdata = parseconfxmlstruct(xmldata)

% Header

headeridx = find(strcmp({xmldata.Children.Name},'Header'));
headerxml = xmldata.Children(headeridx);

nattributes = length(headerxml.Attributes);

for i = 1:nattributes,
    header.(headerxml.Attributes(i).Name) = headerxml.Attributes(i).Value;
end

transceiversidx = find(strcmp({xmldata.Children.Name},'Transceivers'));
transceiversxml = xmldata.Children(transceiversidx);

ntransceivers = length(transceiversxml.Children);

for i = 1:ntransceivers,
   transceiverxml = transceiversxml.Children(i);
   transceivers(i).id =  transceiverxml.Name;
   nattributes = length(transceiverxml.Attributes);
   for j = 1:nattributes,
       transceivers(i).(transceiverxml.Attributes(j).Name) = transceiverxml.Attributes(j).Value;
   end
   
   channelsxml = transceiverxml.Children;
   nchannels = length(channelsxml.Children);
   channels = [];
   for j = 1:nchannels,
       channelxml = channelsxml.Children(j);
       channels(j).Name = channelxml.Name;
       nattributes = length(channelxml.Attributes);
       for k = 1:nattributes,
           channels(j).(channelxml.Attributes(k).Name) = channelxml.Attributes(k).Value;
       end
       
       transducer = [];
       transducerxml = channelxml.Children;
       nattributes = length(transducerxml.Attributes);
       for m = 1:nattributes,
           transducer.(transducerxml.Attributes(m).Name) = transducerxml.Attributes(m).Value;
       end
       channels(j).transducer = transducer;
   end
   transceivers(i).channels = channels;
end  

% Everything comes through as text, so convert selected numerical
% fields into text
for j = 1:length(transceivers)
    names = fieldnames(transceivers(j).channels);
    for k = 1:length(names)
        if sum(strcmp(names{k}, {'Name', 'ChannelIdLong', 'transducer',...
                'ChannelID','ChannelIdShort',})) == 0
            for chan = 1:length(transceivers(j).channels)%nchannels %% FOR LOOP ADDED 2/11/2021 by RK
            transceivers(j).channels(chan).(names{k}) ...
                = num2str(transceivers(j).channels(chan).(names{k}));
            end
        end
    end
end
    for chan = 1:length(transceivers(j).channels)%nchannels %% FOR LOOP ADDED 2/11/2021 by RK
    names = fieldnames(transceivers(j).channels(chan).transducer);
    for k = 1:length(names)
        if ~strcmp(names{k}, 'TransducerName')
            transceivers(j).channels(chan).transducer.(names{k}) ...
                = str2num(transceivers(j).channels(chan).transducer.(names{k}));
        end
    end
    end


confdata.header = header;
confdata.transceivers = transceivers;
end