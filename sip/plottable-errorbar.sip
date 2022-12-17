/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPErrorBarsData
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPErrorBarsData();
  explicit QCPErrorBarsData(double error);
  QCPErrorBarsData(double errorMinus, double errorPlus);
  
  double errorMinus;
  double errorPlus;
};

typedef QVector<QCPErrorBarsData> QCPErrorBarsDataContainer;

class QCPErrorBars : public QCPAbstractPlottable, public QCPPlottableInterface1D
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum ErrorType { etKeyError    ///< The errors are for the key dimension (bars appear parallel to the key axis)
                   ,etValueError ///< The errors are for the value dimension (bars appear parallel to the value axis)
  };
  
  explicit QCPErrorBars(QCPAxis *keyAxis, QCPAxis *valueAxis) /Transfer/;
  virtual ~QCPErrorBars();

  // getters:
  QCPErrorBarsDataContainer* data() const;
  %MethodCode
    sipRes = sipCpp->data().data();
  %End
  QCPAbstractPlottable *dataPlottable() const;
  ErrorType errorType() const;
  double whiskerWidth() const;
  double symbolGap() const;
  
  // setters:
  void setData(QCPErrorBarsDataContainer *data);
  %MethodCode
    sipCpp->setData(QSharedPointer<QCPErrorBarsDataContainer>(a0));
  %End
  void setData(const QVector<double> &error);
  void setData(const QVector<double> &errorMinus, const QVector<double> &errorPlus);
  void setDataPlottable(QCPAbstractPlottable *plottable);
  void setErrorType(ErrorType type);
  void setWhiskerWidth(double pixels);
  void setSymbolGap(double pixels);
  
  // non-property methods:
  void addData(const QVector<double> &error);
  void addData(const QVector<double> &errorMinus, const QVector<double> &errorPlus);
  void addData(double error);
  void addData(double errorMinus, double errorPlus);
  
  // virtual methods of 1d plottable interface:
  virtual int dataCount() const;
  virtual double dataMainKey(int index) const;
  virtual double dataSortKey(int index) const;
  virtual double dataMainValue(int index) const;
  virtual QCPRange dataValueRange(int index) const;
  virtual QPointF dataPixelPosition(int index) const;
  virtual bool sortKeyIsMainKey() const;
  virtual QCPDataSelection selectTestRect(const QRectF &rect, bool onlySelectable) const;
  virtual int findBegin(double sortKey, bool expandedRange=true) const;
  virtual int findEnd(double sortKey, bool expandedRange=true) const;
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual QCPPlottableInterface1D *interface1D();

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual void drawLegendIcon(QCPPainter *painter, const QRectF &rect) const;
  virtual QCPRange getKeyRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth) const;
  virtual QCPRange getValueRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange()) const;

  // non-virtual methods:
//   void getErrorBarLines(QCPErrorBarsDataContainer::const_iterator it, QVector<QLineF> &backbones, QVector<QLineF> &whiskers) const;
//   void getVisibleDataBounds(QCPErrorBarsDataContainer::const_iterator &begin, QCPErrorBarsDataContainer::const_iterator &end, const QCPDataRange &rangeRestriction) const;
//   double pointDistance(const QPointF &pixelPoint, QCPErrorBarsDataContainer::const_iterator &closestData) const;
  // helpers:
  void getDataSegments(QList<QCPDataRange> &selectedSegments, QList<QCPDataRange> &unselectedSegments) const;
  bool errorBarVisible(int index) const;
  bool rectIntersectsLine(const QRectF &pixelRect, const QLineF &line) const;
};
