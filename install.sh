#!/bin/bash

#1) Create and activate environment
ENVS=$(conda info --envs | awk '{print $1}' )
if [[ $ENVS = *"TADATrain"* ]]; then
   source activate DAClassifier
else
   echo "Creating a new conda environment for TADATrain project..."
   conda create -n DAClassifier pip python=3.6
   source activate DAClassifier
   #exit
fi;

#2) Install python dependencies
pip install nltk
pip install scikit-learn
pip install spacy
python -m spacy download en


#3) Download publicly available corpora
if [ ! -d "data/Switchboard/" ] ; then
    mkdir data/Switchboard
fi

if [ ! -d "data/Maptask/" ] ; then
    mkdir data/Maptask
fi

if [ ! -d "data/AMI/" ] ; then
    mkdir data/AMI
fi

if [ ! -d "data/Oasis" ] ; then
    mkdir data/Oasis
fi

if [ ! -d "data/Switchboard/corpus" ] ; then
	echo "Downloading the Switchboard Dialog Act corpus"
	cd data/Switchboard && mkdir corpus && cd corpus && wget https://web.stanford.edu/~jurafsky/swb1_dialogact_annot.tar.gz && tar xvzf swb1_dialogact_annot.tar.gz && rm -rf swb1_dialogact_annot.tar.gz
fi


if [ ! -d "data/Maptask/maptaskv2-1" ] ; then
	echo "Downloading the Maptask corpus"
	wget http://groups.inf.ed.ac.uk/maptask/hcrcmaptask.nxtformatv2-1.zip && unzip -q hcrcmaptask.nxtformatv2-1.zip && rm -rf hcrcmaptask.nxtformatv2-1.zip && mv maptaskv2-1 data/Maptask/maptaskv2-1
fi

if [ ! -d "data/AMI/corpus" ] ; then
	echo "Downloading the AMI corpus"
	 mkdir corpus && cd corpus && wget http://groups.inf.ed.ac.uk/ami/AMICorpusAnnotations/ami_public_manual_1.6.2.zip && unzip -q ami_public_manual_1.6.2.zip && rm -f ami_public_manual_1.6.2.zip && cd .. && mv corpus data/AMI/corpus
fi

if [ ! -d "data/Oasis/corpus" ] ; then
	echo "Downloading the Oasis corpus"
         mkdir corpus && cd corpus && wget http://groups.inf.ed.ac.uk/oasis/download/oasis_full_rel1.0.zip && unzip -q oasis_full_rel1.0.zip && rm -f oasis_full_rel1.0.zip && cd .. && mv corpus data/Oasis/corpus
fi

