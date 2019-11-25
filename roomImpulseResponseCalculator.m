function [ responseTime, ISPressure,IRPa,uniqueResponseTime ] = roomImpulseResponseCalculator( imageSourceLocation, receiverPoint, absorptionCoefficients, reflectionIndex )
% roomýmpulseResponseCalculator calculates pressures of imageSource points,
% calculates response time of the imageSources and outputs a room Impulse
% Response
% Syntax 
% INPUTS
% imageSourceLocation : image source point location (x,y,z)
% receiverPoint : receiver point location (x,y,z)
% absorptionCoefficients : absorption coefficients of the surfaces (in octave bands)(N by 8 matrix where N is the number of Surfaces)
% reflectionIndex : reflection history of image sources (consists NaN values and have to be preprocessed)
% OUTPUTS
% responseTime : response time of the image sources in miliseconds
% ISPressure : pressure of the image sources in decibel


 % response time calculation
 receiverMatrix=repmat(receiverPoint,length(imageSourceLocation(:,1)),1);
 sourceRecieverDistance=sqrt((imageSourceLocation(:,1)-receiverMatrix(:,1)).^2+(imageSourceLocation(:,2)-receiverMatrix(:,2)).^2+(imageSourceLocation(:,3)-receiverMatrix(:,3)).^2);
 responseTime=sourceRecieverDistance./343;
 
 
 % ISPressure Calculation
 reflectionCoefficients=sqrt(1-absorptionCoefficients);
 ISPressure=NaN(length(imageSourceLocation(:,1)),8);
 for i=1:length(imageSourceLocation(:,1))
     reflectionIndicies=reflectionIndex(i,:);
     reflectionIndicies=reflectionIndicies(isnan(reflectionIndicies)==0);
     ISPressure(i,:)=(prod(reflectionCoefficients(reflectionIndicies,:),1));
     
 end
 
 
 
 uniqueResponseTime=flipud(unique(responseTime));
 for i=1:length(uniqueResponseTime)
     coincidentResponses=find(responseTime==uniqueResponseTime(i));
     IRPa(i,:)=sum(ISPressure(coincidentResponses,:),1);
 end

end

