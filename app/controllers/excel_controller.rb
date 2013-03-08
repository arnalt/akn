class ExcelController < ApplicationController
  require 'win32ole'


  def index

  @monat = monat_akt
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
   end
  end

  def list
    w = params[:name]
    monat = w


   @arr = I18n.t("date.month_names")
   mo = (@arr.index monat).to_s
   if (mo.length < 2)
      mo = "0" + mo
   end

   @@mo = mo
   @@monat = monat


   @works = current_user.works.where("substr(datum,6,2) = ?", @@mo )
   @total_std = 0.0
   @works.each do |w|
     @total_std += w.std.to_f
   end
   @akt_monat = @@monat

   respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work }
    end
  end

  def ausgabe
  #  @works = params[:work]
    @works = current_user.works.where("substr(datum,6,2) = ?", @@mo)
    jahr = @works[0].datum.to_s

    WIN32OLE.ole_initialize
    exc= WIN32OLE.new('excel.Application')
    wb = exc.Workbooks.Open('C:\Users\Public\daten\tb02.xlsx')
    ws = wb.Worksheets(1)
    exc.visible = true
    ws.Range("B2").value = @@monat
    ws.Range("B3").value = jahr[0,4]
    ws.Range("B4").value = "Arno Altenhofer"
    ws.Range("B5").value = "Kunde"
    ws.Range("B6").value = "Projekt"
    s = 8
    anzahl_tage = 0
    gstd = 0

    @works.each do |w|
      d = w.datum.to_s
      tt = d[8,2]
      tag = tt.to_i
      j = 1

      while j < 32
          if tag == j
            c = "B" + (s + j).to_s
            ws.Range(c).value = w.std.to_s
            gstd  = gstd + w.std
            c = "C" + (s + j).to_s
            ws.Range(c).value = w.erl.to_s
            anzahl_tage += 1
          end
          j += 1
        end
    end
    ws.Range("B40").value = gstd.to_s
    ws.Range("B41").value = anzahl_tage.to_s
  end


end
