classdef Global     %General class to contain the data 
    properties
        CurrentRegion ;     %string
        CumCases;           %double vector
        CumDeath ;          %double vector
        DailyCases;
        DailyDeath;
        Children;          %object vector



    end

    methods
        function obj = Global(covid)  % Construct an instance of this class to be an array
            if nargin ~= 0
                rows = size(covid,1) ;       % F =  covid_data(2:end,1)
                column = size(covid,2);
                l =0 ;
                for i = 2 : rows   %to calculate the number of countries to initialize the array 
                    if isempty(covid{i,2})
                        l =l+1;    
                    end
                end
                obj(l,1) = obj ;
                j =1 ;
                k = 2;
                for i = 2 : rows
                    if isempty(covid{i,2})
                        k = 2 ;
                        obj(j,1).CurrentRegion = covid{i,1};     %filling the names of the countries
                        obj(j).CumCases = covid(i,3:column);     %filling the CumCases of each country
                        obj(j).CumDeath = covid(i,3:column);     %filling the CumDeath of each country
                        j= j+1 ;
                    else   % To fill the states
                        if isempty(obj(j-1).Children) %TO make the children of type Global before making an array
                            obj(j-1).Children = Global ;
                            obj(j-1).Children.CurrentRegion = covid{i,2};
                            obj(j-1).Children.CumCases = covid(i,3:column);
                            obj(j-1).Children.CumDeath = covid(i,3:column);
                        else %making the array
                            obj(j-1).Children(k,1) = Global ;
                            obj(j-1).Children(k,1).CurrentRegion = covid{i,2};
                            obj(j-1).Children(k,1).CumCases = covid(i,3:column);
                            obj(j-1).Children(k,1).CumDeath = covid(i,3:column);
                            k = k + 1 ;
                        end

                    end
                end
            end
        end
        
        function obj = set.CumCases(obj,v)       %set method to make the cumulative cases
            if iscell(v)
                l = length(v) ;
                for i = 1 : l
                    if v{i}(1) < 0     %ensuring there is no negative values
                        v{i}(1) = 0;                    
                    end
                    obj.CumCases = [obj.CumCases v{i}(1)] ;
                end
            else
                obj.CumCases = v;
            end
        end
        
        function obj = set.CumDeath(obj,v)       %set method to make the cumulative death
            if iscell(v)
                l = length(v) ;
                for i = 1 : l
                    if v{i}(2) < 0     %ensuring there is no negative values
                        v{i}(2) = 0;                    
                    end
                    obj.CumDeath = [obj.CumDeath v{i}(2)] ;
                end
            else
                obj.CumDeath = v;
            end
         
        end
       
        
        function obj = worldData(obj)    %filling the global data
            obj.CurrentRegion = 'Global' ;
            r = length(obj.Children) ;
            c = length(obj.Children(1).CumCases) ;
            for i = 1 : c
                TotalCases = 0;
                TotalDeath = 0;
                for j= 1 : r 
                TotalCases = TotalCases +  obj.Children(j).CumCases(i) ;
                TotalDeath = TotalDeath +  obj.Children(j).CumDeath(i) ;
                end
                obj.CumCases = [obj.CumCases TotalCases ] ;
                obj.CumDeath = [obj.CumDeath TotalDeath ] ;
            end
            obj = EachDay(obj) ;
            
        end
        
        function obj = EachDay(obj) %filling the data of each day
            obj.DailyCases = zeros(1,length(obj.CumCases)) ;
            obj.DailyCases(1) = obj.CumCases(1) ;
            obj.DailyDeath(1) = obj.CumDeath(1) ;
            for i = 2: length(obj.CumCases)
                if ( obj.CumCases(i) - obj.CumCases(i-1) ) < 0     %ensuring there is no negative values
                    obj.DailyCases(i) = 0 ;
                else
                    obj.DailyCases(i) = obj.CumCases(i) - obj.CumCases(i-1) ;
                end
                if ( obj.CumDeath(i) - obj.CumDeath(i-1) ) < 0     %ensuring there is no negative values
                    obj.DailyDeath(i) = 0 ;
                else
                obj.DailyDeath(i) = obj.CumDeath(i) - obj.CumDeath(i-1) ;
                end
            end
        end
        
        function obj = FillChild(obj)
            l = length(obj.Children) ;
            
            for i =  1:l
                if isempty(obj.Children(i).Children)
                obj.Children(i) = EachDay(obj.Children(i)) ;
                else
                    obj.Children(i) = EachDay(obj.Children(i)) ;
                    k = length(obj.Children(i).Children) ;
                    for c =1:k
                       obj.Children(i).Children(c) = EachDay(obj.Children(i).Children(c)) ;                        
                    end
                end
            end
        end

        end
end