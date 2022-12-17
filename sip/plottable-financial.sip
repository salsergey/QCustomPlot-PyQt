/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPFinancialData
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPFinancialData();
  QCPFinancialData(double key, double open, double high, double low, double close);
  
  double sortKey() const;
  static QCPFinancialData fromSortKey(double sortKey);
  static bool sortKeyIsMainKey();
  
  double mainKey() const;
  double mainValue() const;
  
  QCPRange valueRange() const;
  
  double key;
  double open;
  double high;
  double low;
  double close;
};

typedef QCPAbstractPlottable1D<QCPFinancialData> QCPAbstractPlottable1D_QCPFinancialData;
typedef QCPDataContainer<QCPFinancialData> QCPFinancialDataContainer;
typedef QCPDataContainerIterator<QCPFinancialData> QCPFinancialDataContainerIterator;

class QCPFinancial : public QCPAbstractPlottable1D_QCPFinancialData
{
%TypeHeaderCode
#include <qcustomplot.h>

typedef QCPAbstractPlottable1D<QCPFinancialData> QCPAbstractPlottable1D_QCPFinancialData;
%End
public:
  enum WidthType { wtAbsolute       ///< width is in absolute pixels
                   ,wtAxisRectRatio ///< width is given by a fraction of the axis rect size
                   ,wtPlotCoords    ///< width is in key coordinates and thus scales with the key axis range
                 };

  enum ChartStyle { csOhlc         ///< Open-High-Low-Close bar representation
                   ,csCandlestick  ///< Candlestick representation
                  };
  
  explicit QCPFinancial(QCPAxis *keyAxis, QCPAxis *valueAxis) /Transfer/;
  virtual ~QCPFinancial();
  
  // getters:
  QCPFinancialDataContainer* data() const;
  %MethodCode
    sipRes = sipCpp->data().data();
  %End
  ChartStyle chartStyle() const;
  double width() const;
  WidthType widthType() const;
  bool twoColored() const;
  QBrush brushPositive() const;
  QBrush brushNegative() const;
  QPen penPositive() const;
  QPen penNegative() const;
  
  // setters:
  void setData(QCPFinancialDataContainer *data);
  %MethodCode
    sipCpp->setData(QSharedPointer<QCPFinancialDataContainer>(a0));
  %End
  void setData(const QVector<double> &keys, const QVector<double> &open, const QVector<double> &high, const QVector<double> &low, const QVector<double> &close, bool alreadySorted=false);
  void setChartStyle(ChartStyle style);
  void setWidth(double width);
  void setWidthType(WidthType widthType);
  void setTwoColored(bool twoColored);
  void setBrushPositive(const QBrush &brush);
  void setBrushNegative(const QBrush &brush);
  void setPenPositive(const QPen &pen);
  void setPenNegative(const QPen &pen);
  
  // non-property methods:
  void addData(const QVector<double> &keys, const QVector<double> &open, const QVector<double> &high, const QVector<double> &low, const QVector<double> &close, bool alreadySorted=false);
  void addData(double key, double open, double high, double low, double close);
  
  // reimplemented virtual methods:
  virtual QCPDataSelection selectTestRect(const QRectF &rect, bool onlySelectable) const;
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual QCPRange getKeyRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth) const;
  virtual QCPRange getValueRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange()) const;
  
  // static methods:
  static QCPFinancialDataContainer timeSeriesToOhlc(const QVector<double> &time, const QVector<double> &value, double timeBinSize, double timeBinOffset = 0);

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual void drawLegendIcon(QCPPainter *painter, const QRectF &rect) const;

  // non-virtual methods:
//   void drawOhlcPlot(QCPPainter *painter, const QCPFinancialDataContainer::const_iterator &begin, const QCPFinancialDataContainer::const_iterator &end, bool isSelected);
//   void drawCandlestickPlot(QCPPainter *painter, const QCPFinancialDataContainer::const_iterator &begin, const QCPFinancialDataContainer::const_iterator &end, bool isSelected);
  double getPixelWidth(double key, double keyPixel) const;
//   double ohlcSelectTest(const QPointF &pos, const QCPFinancialDataContainer::const_iterator &begin, const QCPFinancialDataContainer::const_iterator &end, QCPFinancialDataContainer::const_iterator &closestDataPoint) const;
//   double candlestickSelectTest(const QPointF &pos, const QCPFinancialDataContainer::const_iterator &begin, const QCPFinancialDataContainer::const_iterator &end, QCPFinancialDataContainer::const_iterator &closestDataPoint) const;
//   void getVisibleDataBounds(QCPFinancialDataContainer::const_iterator &begin, QCPFinancialDataContainer::const_iterator &end) const;
//   QRectF selectionHitBox(QCPFinancialDataContainer::const_iterator it) const;
};
